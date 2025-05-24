import React from "react";
import HeroSection from "./HeroSection";
import DiagnosePage from "./DiagnosePage";
import GovtScheme from "./GovtScheme";
import Services from "./Services";

const Home = () => {
  return (
    <div>
      <HeroSection />
      <DiagnosePage />
      <GovtScheme />
      <Services />
    </div>
  );
};

export default Home;
