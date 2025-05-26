require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { NEXT_PUBLIC_POLYGON_MUMBAI_RPC, NEXT_PUBLIC_PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  // defaultNetwork: "matic",
  // networks: {
  //   hardhat: {},
  //   polygon_mumbai: {
  //     url: NEXT_PUBLIC_POLYGON_MUMBAI_RPC,
  //     accounts: [`0x${NEXT_PUBLIC_PRIVATE_KEY}`],
  //   },
  // },
};

