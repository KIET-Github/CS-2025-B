import React from "react";
import Image from "next/image";
import { StaticImport } from "next/dist/shared/lib/get-img-props";
const PopluarCityLogo = ({
  city,
}: {
  city: {
    id: number;
    name: string;
    link: string;
    image: StaticImport;
  };
}) => {
  return (
    <div className="group/city cursor-pointer flex flex-col justify-center items-center">
      <Image
        className=""
        src={city.image}
        alt={city.name}
        width={50}
        height={50}
      />
      <h1 className="text-lg font-medium group-hover/city:text-primary transition-colors ease-in-out">
        {city.name}
      </h1>
    </div>
  );
};

export default PopluarCityLogo;
