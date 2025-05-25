from flask import Flask, render_template, request, redirect, url_for
from tensorflow.keras.models import load_model
import numpy as np
from PIL import Image
import tensorflow as tf
import os

# Initialize the Flask app
app = Flask(__name__)

# Load the pre-trained model
model = load_model('model.h5')  # Path to the model file

# Set up the upload folder and allowed extensions
app.config['UPLOAD_FOLDER'] = 'static/uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg', 'gif'}

# Function to check if the file extension is valid
def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

# Route for the homepage (index)
@app.route('/')
def index():
    return render_template('index.html')

# Route to handle image uploads and make predictions
@app.route('/predict', methods=['POST'])
def predict():
    # Check if the post request has the file part
    if 'file' not in request.files:
        return redirect(request.url)
    
    file = request.files['file']
    
    # If no file is selected
    if file.filename == '':
        return redirect(request.url)

    if file and allowed_file(file.filename):
        filename = os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(filename)

        # Preprocess the image
        img = Image.open(filename)
        img = img.resize((224, 224))  # Resize to model input size
        img_array = np.array(img) / 255.0  # Normalize pixel values
        img_array = np.expand_dims(img_array, axis=0)

        # Make prediction
        prediction = model.predict(img_array)
        result = 'Water Body' if prediction >= 0.5 else 'Non-Water Body'

        return render_template('index.html', result=result, image_url=filename)

    return redirect(request.url)

if __name__ == '__main__':
    app.run(debug=True)
