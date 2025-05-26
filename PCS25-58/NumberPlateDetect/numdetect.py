import cv2
import pytesseract

# Path to OpenCV's pre-trained Haar Cascade for Russian license plates
# You can download it from OpenCV's GitHub repo or use your own cascade
CASCADE_PATH = 'C:/Users/Manik/Downloads/haarcascade_russian_plate_number.xml'


# Configure Tesseract executable location (if needed)
# pytesseract.pytesseract.tesseract_cmd = r'/usr/bin/tesseract'


def detect_license_plate(image_path, cascade_path=CASCADE_PATH):
    """
    Detects license plates in an image using Haar Cascade classifier.
    Returns list of bounding boxes [(x, y, w, h), ...]
    """
    # Load the cascade classifier
    plate_cascade = cv2.CascadeClassifier(cascade_path)
    
    # Read and convert image to grayscale
    image = cv2.imread(image_path)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Detect plates
    plates = plate_cascade.detectMultiScale(
        gray,
        scaleFactor=1.1,
        minNeighbors=5,
        minSize=(60, 20),
        flags=cv2.CASCADE_SCALE_IMAGE
    )
    
    return image, plates


def recognize_plate_text(image, plates):
    """
    Crops detected plates and uses Tesseract OCR to recognize text.
    Returns list of (bbox, text) tuples.
    """
    results = []
    for (x, y, w, h) in plates:
        # Crop the region of interest
        plate_img = image[y:y + h, x:x + w]
        # Preprocess for OCR: convert to grayscale and threshold
        gray_plate = cv2.cvtColor(plate_img, cv2.COLOR_BGR2GRAY)
        _, thresh = cv2.threshold(gray_plate, 127, 255, cv2.THRESH_BINARY)

        # OCR
        text = pytesseract.image_to_string(thresh, config='--psm 8 --oem 3 -c tessedit_char_whitelist=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789')
        # Clean up text
        text = ''.join(filter(str.isalnum, text))
        results.append(((x, y, w, h), text))
    return results


def annotate_and_display(image, plate_data):
    """
    Draws bounding boxes and recognized text on the image, then displays it.
    """
    for ((x, y, w, h), text) in plate_data:
        cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
        cv2.putText(image, text, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX,
                    0.9, (0, 255, 0), 2)

    cv2.imshow('License Plate Detection', image)
    cv2.waitKey(0)
    cv2.destroyAllWindows()


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(description='License Plate Detection and Recognition')
    parser.add_argument('image', help='Path to input image file')
    parser.add_argument('-c', '--cascade', default=CASCADE_PATH, help='Path to Haar Cascade XML file')
    args = parser.parse_args()

    # Detect plates
    img, plates = detect_license_plate(args.image, args.cascade)
    if len(plates) == 0:
        print('No license plates detected.')
        exit(0)

    # Recognize text
    plate_text = recognize_plate_text(img, plates)
    for (_, text) in plate_text:
        print(f'Detected plate: {text}')

    # Annotate and display
    annotate_and_display(img, plate_text)
