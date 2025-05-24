import React from "react";
import { Link } from "react-router-dom"; // Import Link for internal navigation
import SectionImage from "../assets/Plant.png";
import { useSelector } from "react-redux";
import lang from "../utils/languages";

const DiagnosePage = () => {
  const langKey = useSelector((store) => store.config.lang);

  return (
    <section className="flex flex-col md:flex-row items-center justify-between p-8 bg-white">
      {/* Left Half: Image */}
      <div className="flex-1 flex justify-center items-center mb-8 md:mb-0">
        <img src={SectionImage} alt="Section" className="object-cover rounded-lg" />
      </div>

      {/* Right Half: Heading, Subheading, and Button */}
      <div className="flex-1 flex flex-col justify-center items-center text-center md:text-left">
        <h1 className="text-6xl font-bold mb-4">
          {lang[langKey]?.plantHealthDiag || "Plant Health Diagnosis"}
        </h1>
        <h2 className="text-3xl w-96 text-center text-gray-700 mb-6">
          {lang[langKey]?.checkCrop || "Check Your Crop's Health"}
        </h2>

        {/* Button with Internal Navigation */}
        <Link to="/disease-identification">
          <button className="px-6 mt-7 py-3 border-2 font-bold text-green-600 border-green-500 rounded-lg transition duration-300 hover:bg-green-500 hover:text-white">
            {lang[langKey]?.diagnosePlant || "Diagnose Plant"}
          </button>
        </Link>
      </div>
    </section>
  );
};

export default DiagnosePage;
