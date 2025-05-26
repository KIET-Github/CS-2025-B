import React, { useEffect, useState, useContext } from "react";

//INTRNAL IMPORT
import Style from "../styles/searchPage.module.css";
import { Slider, Loader } from "../components/componentsindex";
import { SearchBar } from "../SearchPage/searchBarIndex";
import { Filter } from "../components/componentsindex";

import { NFTCardTwo, Banner } from "../collectionPage/collectionIndex";
import images from "../img";

//SMART CONTRACT IMPORT
import { NFTMarketplaceContext } from "../Context/NFTMarketplaceContext";

const searchPage = () => {
  const { fetchNFTs, setError, currentAccount } = useContext(
    NFTMarketplaceContext
  );
  const [nfts, setNfts] = useState([]);
  const [nftsCopy, setNftsCopy] = useState([]);

  useEffect(() => {
    try {
      // if (currentAccount) {
      fetchNFTs().then((items) => {
        setNfts(items?.reverse());
        setNftsCopy(items);
        console.log(nfts);
      });
      // }
    } catch (error) {
      setError("Please reload the browser", error);
    }
  }, []);

  const onHandleSearch = (value) => {
    if (!value || !Array.isArray(nfts) || !Array.isArray(nftsCopy)) {
      setNfts(nftsCopy ?? []);
      return;
    }
  
    const filteredNFTS = nfts.filter(({ name }) =>
      name?.toLowerCase().includes(value.toLowerCase())
    );
  
    setNfts(filteredNFTS.length > 0 ? filteredNFTS : nftsCopy);
  };
  

  const onClearSearch = () => {
    if (nfts.length && nftsCopy.length) {
      setNfts(nftsCopy);
    }
  };

  // const collectionArray = [
  //   images.nft_image_1,
  //   images.nft_image_2,
  //   images.nft_image_3,
  //   images.nft_image_1,
  //   images.nft_image_2,
  //   images.nft_image_3,
  //   images.nft_image_1,
  //   images.nft_image_2,
  // ];
  return (
    <div className={Style.searchPage}>
      <Banner bannerImage={images.creatorbackground2} />
      <SearchBar onHandleSearch={onHandleSearch} onClearSearch={onClearSearch} />
      <Filter />
      {Array.isArray(nfts) && nfts.length > 0 ? <NFTCardTwo NFTData={nfts} /> : <Loader />}
      <Slider />
    </div>
  );
  
};

export default searchPage;
