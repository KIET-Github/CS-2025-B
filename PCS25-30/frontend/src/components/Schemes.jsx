import React, { useEffect, useState } from "react";
import axios from "axios";

const Schemes = () => {
  const [schemes, setSchemes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    axios.get("http://localhost:8000/api/schemes/")
      .then(response => {
        setSchemes(response.data);
        setLoading(false);
      })
      .catch(error => {
        setError(error);
        setLoading(false);
      });
  }, []);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;

  return (
    <div className="p-8 bg-gray-100 min-h-screen">
      <h1 className="text-4xl font-bold text-center mb-12">Government Schemes</h1>
      <div>
        {schemes.map((scheme) => (
          <div key={scheme.id} className="flex-1">
            <div className="p-6 border border-gray-300 bg-white rounded-lg mb-8 shadow-md">
              <h2 className="text-2xl font-semibold text-green-600 mb-2">
                {scheme.name}
              </h2>
              <p className="text-lg mt-3">
                {scheme.description}
              </p>
              <a
                href={scheme.more}
                className="text-blue-500 hover:underline"
                target="_blank"
                rel="noopener noreferrer"
              >
                Explore More
              </a>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Schemes;
