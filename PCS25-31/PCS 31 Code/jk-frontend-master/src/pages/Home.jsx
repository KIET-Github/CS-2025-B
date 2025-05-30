import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { handleError, handleSuccess } from '../utils';
import { ToastContainer } from 'react-toastify';
import './Home.css'; // Import the CSS file

function Home() {
  const [loggedInUser, setLoggedInUser] = useState('');
  const [products, setProducts] = useState('');
  const [imagePreview, setImagePreview] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    setLoggedInUser(localStorage.getItem('loggedInUser'));
  }, []);

  const handleLogout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('loggedInUser');
    handleSuccess('User Logged out');
    setTimeout(() => {
      navigate('/login');
    }, 1000);
  };

  const fetchProducts = async () => {
    try {
      const url = 'https://deploy-mern-app-1-api.vercel.app/products';
      const headers = {
        headers: {
          'Authorization': localStorage.getItem('token'),
        },
      };
      const response = await fetch(url, headers);
      const result = await response.json();
      console.log(result);
      setProducts(result);
    } catch (err) {
      handleError(err);
    }
  };

  useEffect(() => {
    fetchProducts();
  }, []);

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImagePreview(reader.result);
      };
      reader.readAsDataURL(file);
    }
  };

  return (
    <div className="home-container">
      <nav className="navbar">
        <h2 className="logo">CareerDendogram</h2>
        <div className="nav-buttons">
          <a
            href="http://127.0.0.1:5000/"
            target="_blank"
            rel="noopener noreferrer"
            className="nav-link"
          >
            Career Recommendation
          </a>
          <button className="logout-button" onClick={handleLogout}>
            Logout
          </button>
        </div>
      </nav>

      <div className="content">
        <h1 className="greeting">
          Welcome {loggedInUser?.split('@')[0]} !!!
        </h1>

        <div className="avatar-container">
          <label htmlFor="avatar-upload">
            <img
              src={
                imagePreview ||
                'https://cdn-icons-png.flaticon.com/512/924/924915.png'
              }
              alt="Avatar"
              className="avatar"
            />
            <input
              type="file"
              accept="image/*"
              id="avatar-upload"
              className="file-input"
              onChange={handleImageChange}
            />
          </label>
          <p className="upload-hint">(Click image to upload)</p>
        </div>
      </div>

      <ToastContainer />
    </div>
  );
}

export default Home;
