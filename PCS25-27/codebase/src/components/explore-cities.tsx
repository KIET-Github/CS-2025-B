import React from "react";
import { exploreCities } from "@/constant";
import ExploreCityCard from "./explore-city-card";
const ExploreCities = () => {
  const displayExploreCities = exploreCities.map((city) => {
    return <ExploreCityCard key={city.id} city={city} />;
  });
  return (
    <div className="px-6">
      <h1 className="text-3xl font-bold my-6 ">Explore Cities</h1>
      <div className="grid grid-cols-3 gap-6">{displayExploreCities}</div>
    </div>
  );
};
export default ExploreCities;
