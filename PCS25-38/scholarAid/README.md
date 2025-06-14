# ScholarAid 🎓

ScholarAid is a comprehensive scholarship management system designed to simplify and streamline the process of managing scholarships for students, institutions, and administrators. It provides a centralized platform where students can apply for scholarships, and administrators can review, approve, and manage applications effectively.

## 📌 Features

- 📝 Student registration and login
- 🎓 Scholarship listing and detailed view
- 📤 Online scholarship application submission
- 📄 Document upload and verification
- 🧾 Admin dashboard to manage scholarships and applications
- 📬 Automated email notifications for status updates
- 🔒 Secure authentication and role-based access control

## 🛠️ Tech Stack

**Frontend:**

- HTML, CSS, JavaScript
- React.js

**Backend:**

- Node.js
- Express.js

**Database:**

- MongoDB

**Other Tools:**

- JWT for authentication
- Multer for file uploads
- Nodemailer for email notifications

## 🚀 Installation & Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jatishsheoran/scholaraid.git
   cd scholaraid
   ```

2. **Backend setup:**

   ```bash
   cd backend
   npm install
   npm run dev
   ```

3. **Frontend setup:**

   ```bash
   cd frontend
   npm install
   npm start
   ```

4. **Environment Variables:**
   Create a `.env` file in the root of your backend directory with the following:
   ```env
   MONGODB_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret
   EMAIL_USER=your_email@example.com
   EMAIL_PASS=your_email_password
   ```

## 📚 Use Cases

- Colleges can list and manage scholarships for their students.
- Students can easily find and apply for relevant scholarships.
- Admins can verify, approve, or reject applications.

---

> "Education is the most powerful weapon which you can use to change the world." – Nelson Mandela
