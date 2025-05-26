import gateWayOfIndia from "../../public/gatewayOfIndia.svg";
import indiaGate from "../../public/indiaGate.svg";
import openHand from "../../public/openHand.svg";
import vidhanaSoudha from "../../public/vidhanaSoudha.svg";
import charminar from "../../public/charminar.svg";
import { StaticImport } from "next/dist/shared/lib/get-img-props";
import charMinarImage from "../../public/charminar.jpg";
import amberfort from "../../public/abmerfort.jpg";
import imambara from "../../public/imambara.png";
import redFort from "../../public/redFort.jpeg";
import statueOfUnity from "../../public/statueOfUnity.jpg";
import lotusTemple from "../../public/lotusTemple.jpg";
import tajMahal from "../../public/tajMahal.avif";
import imambara2 from "../../public/imambara-2.jpg";
import imambara3 from "../../public/imambara-3.jpg";

import qutubMinar from "../../public/qutubMinar.jpg";
export const popularCities = [
  {
    id: 1,
    image: gateWayOfIndia as StaticImport,
    name: "Mumbai",
    link: "/city/mumbai",
  },
  {
    id: 2,
    image: indiaGate as StaticImport,
    name: "Delhi",
    link: "/city/delhi",
  },
  {
    id: 3,
    image: openHand as StaticImport,
    name: "Chandigarh",
    link: "/city/chandigarh",
  },
  {
    id: 4,
    image: vidhanaSoudha as StaticImport,
    name: "Bengaluru",
    link: "/city/bengaluru",
  },
  {
    id: 5,
    image: charminar as StaticImport,
    name: "Hyderbad",
    link: "/city/hyderabad",
  },
];

export const exploreCities = [
  {
    id: 1,
    image: charMinarImage as StaticImport,
    name: "Hyderabad",
    link: "/city/hyderabad",
  },
  {
    id: 2,
    image: imambara as StaticImport,
    name: "Lucknow",
    link: "/city/lucknow",
  },
  {
    id: 3,
    image: redFort as StaticImport,
    name: "Delhi",
    link: "/city/delhi",
  },
  {
    id: 4,
    image: statueOfUnity as StaticImport,
    name: "Gujarat",
    link: "/city/gujrat",
  },
  {
    id: 5,
    image: tajMahal as StaticImport,
    name: "Agra",
    link: "/city/agra",
  },
  {
    id: 6,
    image: amberfort as StaticImport,
    name: "Jaipur",
    link: "/city/jaipur",
  },
  {
    id: 7,
    image: lotusTemple as StaticImport,
    name: "New Delhi",
    link: "/city/delhi",
  },
];

export const popularMonuments = [
  {
    name: "lucknow",
    monuments: [
      {
        id: 1,
        image: imambara as StaticImport,
        name: "Imambara",
        link: "/monument/imambara",
      },
    ],
  },
  {
    name: "delhi",
    monuments: [
      {
        id: 1,
        image: qutubMinar as StaticImport,
        name: "Qutub Minar",
        link: "/monument/qutubminar",
      },
    ],
  },
  {
    name: "hyderabad",
    monuments: [
      {
        id: 1,
        image: charMinarImage as StaticImport,
        name: "charminar",
        link: "/monument/charminar",
      },
    ],
  },
];

export const monuments = [
  {
    name: "imambara",
    image: imambara as StaticImport,
    images: [
      imambara as StaticImport,
      imambara2 as StaticImport,
      imambara3 as StaticImport,
    ],
    description:
      "Bara Imambara in Lucknow is a historical monument dating back to 1784, built by Asaf-ud-Daula, the fourth Nawab of Awadh. This magnificent structure was constructed during a devastating famine to provide employment to the people. The complex includes the main hall, which is one of the largest arched constructions in the world without any supporting beams. Its most fascinating feature is the 'Bhulbhulaiya' or labyrinth, a complex maze of narrow passageways with over 1000 interconnected passages. The Imambara also houses a unique architectural marvel - a staircase that can be ascended by five people simultaneously, each unable to see the others. The monument stands as a testament to the rich cultural heritage and architectural brilliance of the Nawabi era in Lucknow.",
    openingTiming: "9:00AM",
    closingTiming: "6:00PM",
    daysOpened: "Mon-fri",
    price: {
      adults: 100,
      children: 50,
    },
    location: "Lucknow, Uttar Pradesh",
    contact: "+91 8989011317",
  },
  {
    name: "Qutub Minar",
    image: qutubMinar as StaticImport,
    images: [
      qutubMinar as StaticImport,
      lotusTemple as StaticImport,
      redFort as StaticImport,
      imambara as StaticImport,
      statueOfUnity as StaticImport,
    ],
    description:
      "Qutub Minar, a UNESCO World Heritage Site in Delhi, is the tallest brick minaret in the world standing at 73 meters (239.5 feet). Construction began in 1192 by Qutb ud-Din Aibak, the first ruler of the Delhi Sultanate, and was completed by his successor Iltutmish. This five-storied tower features intricate carvings of verses from the Quran and elaborate geometric patterns showcasing the rich Indo-Islamic architectural style. The complex also houses the famous Iron Pillar, a 7.2-meter tall pillar that has remarkably resisted corrosion for over 1,600 years, demonstrating ancient India's advanced metallurgical skills. Qutub Minar stands as a testament to the artistry and engineering prowess of medieval Indian craftsmen and symbolizes the military might and cultural flourishing of the Delhi Sultanate.",
    openingTiming: "9:00AM",
    closingTiming: "6:00PM",
    daysOpened: "Mon-fri",
    price: {
      adults: 100,
      children: 50,
    },
    location: "Delhi, India",
    contact: "+91 8989011317",
  },
  {
    name: "charminar",
    image: charMinarImage as StaticImport,
    images: [
      charMinarImage as StaticImport,
      amberfort as StaticImport,
      tajMahal as StaticImport,
      redFort as StaticImport,
      statueOfUnity as StaticImport,
    ],
    description:
      "Charminar, the iconic symbol of Hyderabad, was built in 1591 by Muhammad Quli Qutb Shah, the fifth ruler of the Qutb Shahi dynasty. This magnificent square structure features four grand arches facing the cardinal directions, each with a 56-meter high minaret ('char' meaning four and 'minar' meaning tower). Legend has it that it was built to commemorate the eradication of a plague that had ravaged the city. The monument combines Persian, Hindu, and Islamic architectural styles, with intricate stucco decorations and balconies. The mosque located on its upper floor is one of the oldest in the region. Surrounded by the bustling Laad Bazaar known for its traditional bangles and pearls, Charminar stands as the heart of Hyderabad's rich cultural heritage, connecting its historic Old City with the modern metropolis that has grown around it.",
    openingTiming: "9:00AM",
    closingTiming: "6:00PM",
    daysOpened: "Mon-fri",
    price: {
      adults: 100,
      children: 50,
    },
    location: "Hyderabad, Telangana",
    contact: "+91 8989011317",
  },
];
