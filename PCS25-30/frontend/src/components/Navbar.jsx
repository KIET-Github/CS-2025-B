import React, { useState } from "react";
import { Link } from "react-router-dom";
import Logo from "../assets/newlogo.png";
import lang from "../utils/languages";
import { SUPPORTED_LANGUAGES } from "../utils/constants";
import { useDispatch, useSelector } from "react-redux";
import { changeLanguage } from "../utils/configSlice";

const Navbar = () => {
  const [language, setLanguage] = useState("en"); // default to "en"
  const dispatch = useDispatch();

  const handleLanguageChange = (event) => {
    setLanguage(event.target.value);
    dispatch(changeLanguage(event.target.value));
  };

  const langKey = useSelector((store) => store.config.lang);

  return (
    <nav className="flex justify-between items-center p-4  text-green-900">
      {/* Logo on the left */}
      <Link to="/">
        <div className="text-2xl font-bold">
          <img src={Logo} alt="Logo" className="h-20" />
        </div>
      </Link>

      {/* Buttons in the middle */}
      <div className="flex space-x-6">
        <Link to="/">
          <button className="px-4 py-2 hover:text-green-600 font-medium text-lg rounded-full transition duration-300">
            {lang[langKey]?.home || "Home"}
          </button>
        </Link>
        <Link to="/disease-identification">
          <button className="px-4 py-2 hover:text-green-600 font-medium text-lg rounded-full transition duration-300">
            {lang[langKey]?.diseaseIdenti || "Disease Identification"}
          </button>
        </Link>
        <Link to="/scheme">
          <button className="px-4 py-2 hover:text-green-600 font-medium text-lg rounded-full transition duration-300">
            {lang[langKey]?.govtScheme || "Government Scheme"}
          </button>
        </Link>
        <Link to="/map">
          <button className="px-4 py-2 hover:text-green-600 font-medium text-lg rounded-full transition duration-300">
            {lang[langKey]?.map || "Map"}
          </button>
        </Link>
      </div>

      {/* Dropdown for language on the right */}
      <div className="relative">
        <select
          value={language}
          onChange={handleLanguageChange}
          className="px-2 py-2 bg-green-600 text-white rounded focus:outline-none"
        >
          {SUPPORTED_LANGUAGES.map((lang) => (
            <option key={lang.identifier} value={lang.identifier}>
              {lang.name}
            </option>
          ))}
        </select>
      </div>
    </nav>
  );
};

export default Navbar;
