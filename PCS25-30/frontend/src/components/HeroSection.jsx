import React from "react";
import HeroImage from "../assets/front-img.png"; // Make sure to use your image path
import { useSelector } from "react-redux";
import lang from "../utils/languages";

const HeroSection = () => {

  const langKey = useSelector((store) => store.config.lang);

  return (
    <section className="flex flex-col md:flex-row items-center justify-between p-8">
      <div className="flex-1 ml-36 text-center md:text-left mb-8 md:mb-0">
        <h1 className="text-8xl font-bold mb-4 text-green-900">{lang[langKey]?.heading || "heading"}</h1>
        <h2 className="text-4xl font-semibold text-green-800 mb-6">
          एक कदम सफल कृषि की ओर
        </h2>

        <a
          href="tel:+919368959004"
          className="inline-block mt-20 bg-green-700 text-white py-3 px-6 rounded-lg text-lg font-semibold hover:bg-green-600 transition duration-300"
        >
          {lang[langKey]?.call || "call"}: +91 9368959004
        </a>
      </div>

      <div className="flex-1">
        <img src={HeroImage} alt="Hero" className="object-cover rounded-lg" />
      </div>
    </section>
  );
};

export default HeroSection;
