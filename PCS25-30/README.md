# Project Setup Instructions

This guide will help you set up and run the **Backend** and **Frontend** of the project.

---

##  Backend Setup

1. **Install Python dependencies**  
   Run the following command in the root directory to install the required packages:
   ```bash
   pip install -r requirements.txt
   ```

2. **Create a virtual environment**  
   In the root directory, create a virtual environment:
   ```bash
   python -m venv myenv
   ```

3. **Activate the virtual environment**  
   ```bash
   source myenv/bin/activate
   ```

4. **Navigate to the backend directory**  
   ```bash
   cd backend
   ```

5. **Start the backend server**  
   ```bash
   python manage.py runserver
   ```

---

##  Frontend Setup

1. **Install Node.js dependencies**  
   From the root directory, run:
   ```bash
   npm install
   ```

2. **Navigate to the frontend directory**  
   ```bash
   cd frontend
   ```

3. **Run the development server**  
   ```bash
   npm run dev
   ```

---

## Additional Setup

- **Download Model Weights**  
  Please download the required weights from the given Google Drive link and place them in the appropriate directory as specified in the project documentation.
  https://drive.google.com/drive/folders/17pEgnOtIPad0w86f8zbbg287n4w68sDQ?usp=sharing