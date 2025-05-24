import React from "react";
import SchemeImage from "../assets/2.webp"; // Update with your image path
import lang from "../utils/languages";
import { useSelector } from "react-redux";

const GovtScheme = () => {

  const langKey = useSelector((store) => store.config.lang);

  return (
    <section className="flex flex-col md:flex-row items-center justify-between p-8 mt-20 mb-20">
      {/* Left Half: Heading and Subheading */}
      <div className="flex-1 flex flex-col justify-center items-center text-center mt-16 md:text-left mb-8 md:mb-0">
        <h1 className="text-5xl font-bold text-green-900 mb-4">{lang[langKey]?.govtScheme || "govtScheme"}</h1>
        <h2 className="text-2xl w-96 text-center text-gray-700 mb-6">{lang[langKey]?.discSchemes || "discSchemes"}</h2>
      </div>

      {/* Right Half: Image */}
      <div className="flex-1 flex justify-center items-center">
        <img src={SchemeImage} alt="Government Scheme" className="h-72 object-cover rounded-lg" />
      </div>
    </section>
  );
};

export default GovtScheme;
