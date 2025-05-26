import React from "react";
import { popularMonuments } from "@/constant";

import PoplularMonumentCard from "@/components/popular-monument-card";
const page = ({
  params,
}: {
  params: {
    cityname: string;
  };
}) => {
  const filteredCity = popularMonuments.find(
    (monument) => monument.name == params.cityname
  );
  const displayPopularMonuments = filteredCity?.monuments.map((monument) => {
    return <PoplularMonumentCard monument={monument} key={monument.id} />;
  });
  return (
    <div className="px-9 py-6 flex flex-col space-y-4">
      <h1 className="text-5xl font-bold capitalize">{params.cityname}</h1>
      <h3 className="text-3xl font-semibold">
        Famous Monuments and Heritage sites
      </h3>
      <div className="grid grid-cols-3 gap-6">{displayPopularMonuments}</div>
    </div>
  );
};

export default page;
