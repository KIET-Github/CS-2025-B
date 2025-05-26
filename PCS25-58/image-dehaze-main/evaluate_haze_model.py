import numpy as np
import skimage.io as io
import skimage.metrics as metrics
from haze_removal import HazeRemoval

def evaluate_haze_removal(input_image_path, ground_truth_path, output_image_path):
    # Load images
    input_image = io.imread(input_image_path).astype(np.float32) / 255
    ground_truth = io.imread(ground_truth_path).astype(np.float32) / 255

    # Apply haze removal
    haze_removal = HazeRemoval()
    haze_removal.open_image(input_image_path)
    haze_removal.get_dark_channel()
    haze_removal.get_air_light()
    haze_removal.get_transmission()
    haze_removal.guided_filter()
    haze_removal.recover()
    haze_removal.show()
    
    # Save output image
    io.imsave(output_image_path, haze_removal.dst)
    
    # Load output image
    output_image = io.imread(output_image_path).astype(np.float32) / 255

    # Check image dimensions
    img_height, img_width = ground_truth.shape[:2]
    print(f"Image dimensions: {img_width}x{img_height}")

    # Define window size for SSIM computation
    min_dim = min(img_width, img_height)
    win_size = min(7, min_dim)  # Ensure win_size is at least 7 and smaller than image dimensions
    
    # Make sure win_size is odd
    if win_size % 2 == 0:
        win_size -= 1
    
    print(f"Using window size: {win_size}")

    # Compute PSNR and SSIM
    psnr_value = metrics.peak_signal_noise_ratio(ground_truth, output_image)
    try:
        ssim_value = metrics.structural_similarity(ground_truth, output_image, multichannel=True, win_size=win_size)
    except ValueError as e:
        print(f"Error in SSIM calculation: {e}")
        ssim_value = None

    return psnr_value, ssim_value

if __name__ == "__main__":
    input_image_path = 'image_eval_in.jpg'
    ground_truth_path = 'image_eval.jpg'
    output_image_path = 'test.jpg'
    
    psnr, ssim = evaluate_haze_removal(input_image_path, ground_truth_path, output_image_path)
    
    print(f"PSNR: {psnr:.2f}")
    # print(f"SSIM: {ssim:.4f}" if ssim is not None else "SSIM calculation failed")
