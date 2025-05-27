import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Home from "./components/Home";
import Schemes from "./components/Schemes";
import MapComponent from "./components/MapComponent";
import Navbar from "./components/Navbar"; // Import Navbar here
import Footer from "./components/Footer";
import DiseaseIdentificationPage from "./components/DiseaseIdentificationPage"; // Import DiseaseIdentificationPage
import appStore from "./utils/appStore";
import { Provider } from "react-redux";
import ScrollToTop from "./components/ScrollToTop";

const App = () => {
  return (
    <Provider store={appStore}>
      
      <Router>
      <ScrollToTop />
        {/* Navbar is placed outside Routes, so it will always be visible */}
        <Navbar />
        <Routes>
          <Route path="/" element={<Home />} />
          <Route
            path="/disease-identification"
            element={<DiseaseIdentificationPage />}
          />
          <Route path="/scheme" element={<Schemes />} />
          <Route path="/map" element={<MapComponent />} />
        </Routes>
        <Footer />
      </Router>
    </Provider>
  );
};

export default App;
