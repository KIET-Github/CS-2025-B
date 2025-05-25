import { StaticImport } from "next/dist/shared/lib/get-img-props";
import React from "react";
import Image from "next/image";
import { Button } from "./ui/button";
import Link from "next/link";
const PoplularMonumentCard = ({
  monument,
}: {
  monument: {
    id: number;
    image: StaticImport;
    name: string;
    link: string;
  };
}) => {
  console.log(monument);
  return (
    <div className="border rounded-md shadow-md flex flex-col space-y-3">
      <Image
        src={monument.image}
        alt={monument.name}
        width={100}
        height={100}
        className="w-full object-contain rounded-t-md shadow-md"
      />
      <div className="px-6 pb-8 space-y-3 flex flex-col">
        <h1 className="text-xl font-semibold">{monument.name}</h1>
        <Link href={monument.link}>
          <Button className="w-full">Book Tickets</Button>
        </Link>
      </div>
    </div>
  );
};

export default PoplularMonumentCard;
