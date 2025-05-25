import os

# Create an "uploads" directory if it doesn't exist
if not os.path.exists('uploads'):
    os.makedirs('uploads')
    print("Uploads folder created")
else:
    print("Uploads folder already exists")
