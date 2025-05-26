import { StaticImport } from "next/dist/shared/lib/get-img-props";
import React from "react";
import Image from "next/image";
import { Button } from "./ui/button";
import Link from "next/link";
const ExploreCityCard = ({
  city,
}: {
  city: {
    id: number;
    name: string;
    image: StaticImport;
    link: string;
  };
}) => {
  return (
    <div className="border rounded-md shadow-md flex flex-col space-y-3">
      <Image
        src={city.image}
        alt={city.name}
        width={100}
        height={100}
        className="w-full aspect-square object-cover rounded-t-md shadow-md"
      />
      <div className="px-6 pb-8 space-y-3 flex flex-col">
        <h1 className="text-xl font-semibold">{city.name}</h1>
        <Link href={city.link}>
          <Button className="w-full">Explore More</Button>
        </Link>
      </div>
    </div>
  );
};

export default ExploreCityCard;
