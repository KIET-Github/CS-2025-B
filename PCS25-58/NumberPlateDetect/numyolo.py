import cv2
import pytesseract
import torch
from pathlib import Path

# Configure Tesseract executable location (if needed)
# pytesseract.pytesseract.tesseract_cmd = r'/usr/bin/tesseract'

# Load YOLOv5 model (using pretrained weights or custom weights)
MODEL_PATH = 'yolov5s.pt'  # Replace with your own model if trained for license plates
model = torch.hub.load('ultralytics/yolov5', 'custom', path=MODEL_PATH, force_reload=True)


def detect_license_plate_yolo(image_path):
    """
    Detect license plates using YOLOv5.
    Returns the original image and bounding boxes [(x1, y1, x2, y2), ...].
    """
    image = cv2.imread(image_path)
    results = model(image)
    detections = results.xyxy[0]  # [x1, y1, x2, y2, conf, cls]

    plates = []
    for *box, conf, cls in detections:
        x1, y1, x2, y2 = map(int, box)
        plates.append((x1, y1, x2, y2))

    return image, plates


def recognize_plate_text(image, plates):
    """
    Crops detected plates and uses Tesseract OCR to recognize text.
    Returns list of (bbox, text) tuples.
    """
    results = []
    for (x1, y1, x2, y2) in plates:
        plate_img = image[y1:y2, x1:x2]
        gray_plate = cv2.cvtColor(plate_img, cv2.COLOR_BGR2GRAY)
        _, thresh = cv2.threshold(gray_plate, 127, 255, cv2.THRESH_BINARY)

        text = pytesseract.image_to_string(thresh, config='--psm 8 --oem 3 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')
        text = ''.join(filter(str.isalnum, text))
        results.append(((x1, y1, x2, y2), text))
    return results


# def annotate_and_display(image, plate_data):
#     """
#     Draws bounding boxes and recognized text on the image, then displays it.
#     """
#     for ((x1, y1, x2, y2), text) in plate_data:
#         cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)
#         cv2.putText(image, text, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX,
#                     0.9, (0, 255, 0), 2)

#     # cv2.imshow('License Plate Detection (YOLO)', image)
#     # cv2.waitKey(0)
#     cv2.imwrite("output_image.jpg", image)
#     print("Annotated image saved as output_image.jpg")
#     cv2.destroyAllWindows()

def annotate_and_display(image, plate_data):
    """
    Draws bounding boxes and recognized text on the image, then saves it.
    """
    for ((x1, y1, x2, y2), text) in plate_data:
        cv2.rectangle(image, (x1, y1), (x2, y2), (0, 255, 0), 2)
        cv2.putText(image, text, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX,
                    0.9, (0, 255, 0), 2)

    output_path = "output_image.jpg"
    cv2.imwrite(output_path, image)
    print(f"Annotated image saved as {output_path}")


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='License Plate Detection with YOLOv5 and Tesseract')
    parser.add_argument('image', help='Path to input image file')
    args = parser.parse_args()

    img, plates = detect_license_plate_yolo(args.image)
    if len(plates) == 0:
        print('No license plates detected.')
        exit(0)

    plate_text = recognize_plate_text(img, plates)
    for (_, text) in plate_text:
        print(f'Detected plate: {text}')

    annotate_and_display(img, plate_text)
