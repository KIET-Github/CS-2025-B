import React, { useState, useContext } from "react";
import Image from "next/image";
import { SiBlockchaindotcom } from "react-icons/si";

//----IMPORT ICONS
import { MdNotifications } from "react-icons/md";
import { BsSearch } from "react-icons/bs";
import { CgMenuRight } from "react-icons/cg";
import { useRouter } from "next/router";

//INTERNAL IMPORT
import Style from "./NavBar.module.css";
import { Discover, HelpCenter, Notification, Profile, SideBar } from "./index";
import { Button, Error } from "../componentsindex";
import images from "../../img";

//IMPORT FROM SMART CONTRACT
import { NFTMarketplaceContext } from "../../Context/NFTMarketplaceContext";

const NavBar = () => {
  //----USESTATE COMPONENTS
  const [discover, setDiscover] = useState(false);
  const [help, setHelp] = useState(false);
  const [notification, setNotification] = useState(false);
  const [profile, setProfile] = useState(false);
  const [openSideMenu, setOpenSideMenu] = useState(false);

  const router = useRouter();
  const { currentAccount, connectWallet, openError } = useContext(
    NFTMarketplaceContext
  );

  // Function to toggle menus
  const openMenu = (menu) => {
    setDiscover(menu === "Discover" ? !discover : false);
    setHelp(menu === "Help Center" ? !help : false);
    setNotification(false);
    setProfile(false);
  };

  const openNotification = () => {
    setNotification(!notification);
    setDiscover(false);
    setHelp(false);
    setProfile(false);
  };

  const openProfile = () => {
    setProfile(!profile);
    setHelp(false);
    setDiscover(false);
    setNotification(false);
  };

  const openSideBar = () => {
    setOpenSideMenu(!openSideMenu);
  };

  return (
    <div className={Style.navbar}>
      <div className={Style.navbar_container}>
        <div className={Style.navbar_container_left}>
          <div className={Style.logo}>
            <SiBlockchaindotcom onClick={() => router.push("/")} />
          </div>
          <div className={Style.navbar_container_left_box_input}>
            <div className={Style.navbar_container_left_box_input_box}>
              <input type="text" placeholder="Search NFT" />
              <BsSearch className={Style.search_icon} />
            </div>
          </div>
        </div>

        {/* RIGHT SECTION */}
        <div className={Style.navbar_container_right}>
          {/* DISCOVER MENU */}
          <div className={Style.navbar_container_right_discover}>
            <p onClick={() => openMenu("Discover")}>Discover</p>
            {discover && (
              <div className={Style.navbar_container_right_discover_box}>
                <Discover />
              </div>
            )}
          </div>

          {/* HELP CENTER MENU */}
          <div className={Style.navbar_container_right_help}>
            <p onClick={() => openMenu("Help Center")}>Help Center</p>
            {help && (
              <div className={Style.navbar_container_right_help_box}>
                <HelpCenter />
              </div>
            )}
          </div>

          {/* NOTIFICATION */}
          <div className={Style.navbar_container_right_notify}>
            <MdNotifications
              className={Style.notify}
              onClick={openNotification}
            />
            {notification && <Notification />}
          </div>

          {/* CREATE / CONNECT BUTTON */}
          <div className={Style.navbar_container_right_button}>
            {currentAccount ? (
              <Button
                btnName="Create"
                handleClick={() => router.push("/uploadNFT")}
              />
            ) : (
              <Button btnName="Connect" handleClick={connectWallet} />
            )}
          </div>

          {/* USER PROFILE */}
          <div className={Style.navbar_container_right_profile_box}>
            <div className={Style.navbar_container_right_profile}>
              <Image
                src={images.user1}
                alt="Profile"
                width={40}
                height={40}
                onClick={openProfile}
                className={Style.navbar_container_right_profile}
              />
              {profile && <Profile currentAccount={currentAccount} />}
            </div>
          </div>

          {/* MENU BUTTON */}
          <div className={Style.navbar_container_right_menuBtn}>
            <CgMenuRight className={Style.menuIcon} onClick={openSideBar} />
          </div>
        </div>
      </div>

      {/* SIDEBAR COMPONENT */}
      {openSideMenu && (
        <div className={Style.sideBar}>
          <SideBar
            setOpenSideMenu={setOpenSideMenu}
            currentAccount={currentAccount}
            connectWallet={connectWallet}
          />
        </div>
      )}

      {openError && <Error />}
    </div>
  );
};

export default NavBar;
