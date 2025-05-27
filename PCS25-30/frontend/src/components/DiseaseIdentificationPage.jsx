import React, { useState } from "react";
import axios from "axios";
import { useSelector } from "react-redux";
import lang from "../utils/languages";

const DiseaseIdentificationPage = () => {
  const [file, setFile] = useState(null);
  const [prediction, setPrediction] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  const langKey = useSelector((store) => store.config.lang);

  const handleFileChange = (event) => {
    setFile(event.target.files[0]);
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    if (!file) return;

    const formData = new FormData();
    formData.append("image", file);

    setLoading(true);
    setError(null);

    try {
      const response = await axios.post("http://localhost:8000/api/diagnose/", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });
      setPrediction(response.data);
    } catch (err) {
      setError("Error occurred while predicting the disease. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="p-8 bg-gray-100 min-h-screen">
      <div className="flex flex-col md:flex-row gap-24 justify-center mt-20">
        <div className="flex-1 ml-24">
          <h1 className="text-4xl font-bold underline underline-offset-2 mb-4">
            {lang[langKey]?.diseaseIdentification || "Disease Identification"}
          </h1>
          <p className="text-lg mb-4">
            {lang[langKey]?.checkIfPlantIsHealthy || "Check if your plant is healthy and find solutions to any diseases."}
          </p>
          <p className="text-lg font-bold mb-4">Details</p>
          <ul className="list-disc pl-5 mb-4">
            <li className="mb-2">Click a clear picture of the leaf of the plant.</li>
            <li className="mb-2">Upload the picture using the upload button.</li>
            <li>
              Once uploaded, the following details will be shown:
              <ul className="list-disc pl-5 mt-2">
                <li className="mb-2">Possible Disease.</li>
                <li className="mb-2">Cure for the Disease.</li>
              </ul>
            </li>
          </ul>
        </div>
        <div className="flex-1 me-20">
          <h2 className="text-2xl font-semibold mb-4">Upload an Image</h2>
          <form onSubmit={handleSubmit} className="flex flex-col">
            <input
              type="file"
              onChange={handleFileChange}
              className="mb-4 border border-gray-300 rounded-md p-2 w-[65%]"
            />
            <button
              type="submit"
              className="px-6 py-3 w-[20%] font-semi border border-transparent rounded-md shadow-sm text-white bg-green-700 hover:bg-green-800"
            >
              {lang[langKey]?.predict || "Predict"}
            </button>
          </form>
          {loading && <p className="mt-4">Loading...</p>}
          {error && <p className="mt-4 text-red-600">{error}</p>}
          {prediction && (
            <div className="mt-10 p-4 border border-gray-300 rounded-md">
              <h3 className="text-xl font-semibold mb-2">Predicted Disease</h3>
              {prediction.disease && <p className="text-2xl font-bold">{prediction.disease}</p>}
              {prediction.confidence && (
                <p><strong>Confidence:</strong> {prediction.confidence}</p>
              )}
              {prediction.description && (
                <div className="mt-2" dangerouslySetInnerHTML={{ __html: prediction.description }} />
              )}
              {prediction.cure && (
                <div className="mt-2">
                  <strong className="text-xl">Cure:</strong>
                  <div dangerouslySetInnerHTML={{ __html: prediction.cure }} />
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default DiseaseIdentificationPage;
