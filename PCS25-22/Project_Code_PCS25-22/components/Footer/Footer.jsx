import React from "react";
import Image from "next/image";
import { DiJqueryLogo } from "react-icons/di";
import {
  TiSocialFacebook,
  TiSocialLinkedin,
  TiSocialTwitter,
  TiSocialYoutube,
  TiSocialInstagram,
  TiArrowSortedDown,
  TiArrowSortedUp,
} from "react-icons/ti";
import { RiSendPlaneFill } from "react-icons/ri";

//INTERNAL IMPORT
import Style from "./Footer.module.css";
import images from "../../img";
import { Discover, HelpCenter } from "../NavBar/index";
import { SiBlockchaindotcom } from "react-icons/si";

const Footer = () => {
  return (
    <div className={Style.footer}>
      <div className={Style.footer_box}>
        <div className={Style.footer_box_social}>
          {/* <Image src={images.logo} alt="footer logo" height={100} width={100} /> */}
          <a href="/">
            <SiBlockchaindotcom className={Style.footer_box_social_logo} />
          </a>
          <p>
          NFT ArtHub – the premier destination for discovering, buying, and selling unique digital collectibles and crypto art. Unlock the future of creativity today!
         <br/>Developed By Ayush Mishra ✌️.
          </p>

          <div className={Style.footer_social}>
            <a href="#">
              <TiSocialFacebook />
            </a>
            <a href="#">
              <TiSocialLinkedin />
            </a>
            <a href="#">
              <TiSocialTwitter />
            </a>
            <a href="#">
              <TiSocialYoutube />
            </a>
            <a href="#">
              <TiSocialInstagram />
            </a>
          </div>
        </div>

        <div className={Style.footer_box_discover}>
          <h3>Discover</h3>
          <Discover />
        </div>

        <div className={Style.footer_box_help}>
          <h3>Help Center</h3>
          <HelpCenter />
        </div>

        <div className={Style.subscribe}>
          <h3>Subscribe</h3>

          <div className={Style.subscribe_box}>
            <input type="email" placeholder="Enter your email *" />
            <RiSendPlaneFill className={Style.subscribe_box_send} />
          </div>
          <div className={Style.subscribe_box_info}>
            <p>
            Discover, collect, and trade unique digital art on NFT ArtHub—the ultimate destination for creators and collectors in the NFT space.
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Footer;
