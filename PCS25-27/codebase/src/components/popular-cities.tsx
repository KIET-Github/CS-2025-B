import React from "react";
import { popularCities } from "@/constant";
import PopluarCityLogo from "./popular-city-logo";
const PopularCities = () => {
  const displayPopularCities = popularCities.map((city) => {
    return <PopluarCityLogo key={city.id} city={city} />;
  });
  return (
    <div className="flex justify-around bg-secondary p-2 shadow-lg">
      {displayPopularCities}
    </div>
  );
};

export default PopularCities;
