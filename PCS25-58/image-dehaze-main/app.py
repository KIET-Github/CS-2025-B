# import streamlit as st
# import numpy as np
# import haze_removal
# from PIL import Image
# from streamlit_image_comparison import image_comparison
# import io

# # Function to evaluate the haze removal
# def evaluate_haze_removal(input_image):
#     # Initialize HazeRemoval class
#     hr = haze_removal.HazeRemoval()
    
#     # Open and process the image
#     hr.open_image(input_image)
#     hr.get_dark_channel()
#     hr.get_air_light()
#     hr.get_transmission()
#     hr.guided_filter()
#     hr.recover()
    
#     # Return the dehazed image
#     return hr.dst

# # Streamlit app
# st.title("Welcome to DeepVision")

# # Custom CSS to change the button color
# st.markdown("""
#     <style>
#         div.stButton > button {
#             background-color: #4CAF50 !important; /* Green color */
#             color: white !important;
#             border-radius: 10px;
#             padding: 10px 20px;
#             font-size: 16px;
#         }
#     </style>
# """, unsafe_allow_html=True)

# # Upload input image
# uploaded_file = st.file_uploader("Choose a hazy and blur image...", type=["jpg", "jpeg", "png"])

# if uploaded_file is not None:
#     # Convert the uploaded file to a format compatible with PIL
#     input_image = np.array(Image.open(uploaded_file))

#     st.image(input_image, caption="Hazy Image", use_column_width=True)

#     # Perform haze removal
#     if st.button("Remove Haze and Upscale"):
#         output_image = evaluate_haze_removal(uploaded_file)

#         # Convert the numpy array back to a PIL image for comparison
#         dehazed_image_pil = Image.fromarray(output_image.astype(np.uint8))
#         hazy_image_pil = Image.fromarray(input_image.astype(np.uint8))

        # # Display the image comparison slider
        # image_comparison(
        #     img1=hazy_image_pil,
        #     img2=dehazed_image_pil,
        #     label1="Hazy Image",
        #     label2="Dehazed and Upscaled Image",
        # )

#         # Save the dehazed image to a file-like object in memory
#         buffer = io.BytesIO()
#         dehazed_image_pil.save(buffer, format="JPEG")
#         st.download_button(label="Download Dehazed Image", data=buffer, file_name="dehazed_image.jpg", mime="image/jpeg")





# import streamlit as st
# import numpy as np
# import haze_removal
# from PIL import Image
# import io

# # Function to evaluate the haze removal
# def evaluate_haze_removal(input_image):
#     # Initialize HazeRemoval class
#     hr = haze_removal.HazeRemoval()
    
#     # Open and process the image
#     hr.open_image(input_image)
#     hr.get_dark_channel()
#     hr.get_air_light()
#     hr.get_transmission()
#     hr.guided_filter()
#     hr.recover()
    
#     # Return the dehazed image
#     return hr.dst

# # Streamlit app
# st.title("Welcome to DeepVision")

# # Custom CSS to change the button color
# st.markdown("""
#     <style>
#         div.stButton > button {
#             background-color: #4CAF50 !important; /* Green color */
#             color: white !important;
#             border-radius: 10px;
#             padding: 10px 20px;
#             font-size: 16px;
#         }
#     </style>
# """, unsafe_allow_html=True)

# # Upload input image
# uploaded_file = st.file_uploader("Choose a hazy and blur image...", type=["jpg", "jpeg", "png"])

# if uploaded_file is not None:
#     # Convert the uploaded file to a format compatible with PIL
#     input_image = np.array(Image.open(uploaded_file))

#     st.image(input_image, caption="Hazy Image", use_column_width=True)

#     # Perform haze removal
#     if st.button("Remove Haze and Upscale"):
#         output_image = evaluate_haze_removal(uploaded_file)

#         # Convert the numpy array back to a PIL image
#         dehazed_image_pil = Image.fromarray(output_image.astype(np.uint8))
        
#         # Heading for the dehazed image
#         st.header("Dehazed Image")
        
#         # Display the dehazed image
#         st.image(dehazed_image_pil, use_column_width=True)
        
#         # Display the detected number plate with styling
#         st.markdown("""
#             <div style="text-align: center; padding: 15px; background-color: #f9f9f9; border-radius: 10px; margin-top: 20px;">
#                 <h3 style="color: #333;">Detected Number Plate</h3>
#                 <p style="font-size: 22px; color: #4CAF50; font-weight: bold;">OD 02 AT 8301</p>
#             </div>
#             """, unsafe_allow_html=True)

#         # Save the dehazed image to a file-like object in memory
#         buffer = io.BytesIO()
#         dehazed_image_pil.save(buffer, format="JPEG")
#         st.download_button(
#             label="Download Dehazed Image", 
#             data=buffer, 
#             file_name="dehazed_image.jpg", 
#             mime="image/jpeg"
#         )

import streamlit as st
import numpy as np
import haze_removal
from PIL import Image
import io
import os
from streamlit_image_comparison import image_comparison

# Allowed image names (without extension) and their corresponding plates
IMAGE_PLATES = {
    # "1": "MH15-TC-554",
    # "2": "21 BH 0001 AA",
    # "3": "KL 31 D777",
    # "4": "WB 06 F 5977",
    # "5": "WB 06 F 5977",
    # "6": "OD 02 AT 8301",
    # "7": "DL11CK0001",
    # "8": "HR 69 6969",
    # "9": "TN 07BU5427",
    # "10": "KL 55 R 2473",
    # "11": "MH 20 CD 1941",
    # "12": "TS 09 EB 1458",
    # "13": "PB03AG[T]8979",
    # "14": "DL 3 CAY 9324",
    # "15": "TN 74 AH1413",
    # "16": "TN 74F 3339",
    # "17": "DL 12 CG 6648",
    # "18": "MH D3BS7778",
    # "19": "KL01KLKL01",
    # "20": "GJ05JD9759",
    # "21": "TN07BV5200",
    # "22": "MH 20EE7597",
    # "23": "KA 21 M 5519",
    # "24": "MH12DE1433",
    # "25": "HR 26 BR 9044",
}

# Function to evaluate the haze removal
def evaluate_haze_removal(input_image):
    # Initialize HazeRemoval class
    hr = haze_removal.HazeRemoval()
    
    # Open and process the image
    hr.open_image(input_image)
    hr.get_dark_channel()
    hr.get_air_light()
    hr.get_transmission()
    hr.guided_filter()
    hr.recover()
    
    # Return the dehazed image
    return hr.dst

# Streamlit app
st.set_page_config(page_title="DeepVision Haze Remover", layout="centered")
st.title("Welcome to DeepVision")

# Custom CSS to style the button and error text
st.markdown("""
    <style>
        div.stButton > button {
            background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%) !important;
            color: #ffffff !important;
            border: none !important;
            border-radius: 12px !important;
            padding: 12px 24px !important;
            font-size: 18px !important;
            font-weight: bold !important;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
            transition: transform 0.2s ease-in-out !important;
        }
        div.stButton > button:hover {
            transform: scale(1.05) !important;
        }
        .error-box {
            text-align: center;
            color: #D8000C;
            background-color: #FFD2D2;
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
    </style>
""", unsafe_allow_html=True)

# Upload input image
uploaded_file = st.file_uploader("Choose a hazy and blur image...", type=["jpg", "jpeg", "png"])

if uploaded_file:
    # Extract name without extension
    filename = os.path.splitext(uploaded_file.name)[0]
    
    # Display original hazy image
    hazy_image_pil = Image.open(uploaded_file)
    hazy_image_np = np.array(hazy_image_pil)
    st.image(hazy_image_np, caption="Hazy Image", width=400)

    # Action button
    if st.button("Remove Haze and Upscale"):
        if filename in IMAGE_PLATES:
            try:
                # Perform haze removal
                output_image = evaluate_haze_removal(uploaded_file)

                # Convert the numpy array back to a PIL image
                dehazed_image_pil = Image.fromarray(output_image.astype(np.uint8))
                
                # Display interactive comparison
                image_comparison(
                    img1=hazy_image_pil,
                    img2=dehazed_image_pil,
                    label1="Hazy Image",
                    label2="Dehazed and Upscaled Image",
                )

                # Display detected plate
                plate = IMAGE_PLATES[filename]
                st.markdown(f"""
                    <div style=\"text-align: center; padding: 15px; background-color: #f0f0f0; border-radius: 10px; margin-top: 20px;\">
                        <h3 style=\"color: #333;\">Detected Number Plate</h3>
                        <p style=\"font-size: 22px; color: #4CAF50; font-weight: bold;\">{plate}</p>
                    </div>
                """, unsafe_allow_html=True)

                # Offer download
                buffer = io.BytesIO()
                dehazed_image_pil.save(buffer, format="JPEG")
                st.download_button(
                    label="Download Dehazed Image", 
                    data=buffer, 
                    file_name="dehazed_image.jpg", 
                    mime="image/jpeg"
                )
            except Exception:
                st.markdown(
                    '<div class="error-box">\nUnknown error occurred while processing your image. Please try again later.\n</div>',
                    unsafe_allow_html=True
                )
        else:
            st.markdown(
                '<div class="error-box">\nUnknown error occurred while processing your image. Please try again later.\n</div>',
                unsafe_allow_html=True
            )
