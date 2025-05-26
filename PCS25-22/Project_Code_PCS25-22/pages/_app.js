import "../styles/globals.css";

// INTERNAL IMPORT
import { NavBar, Footer } from "../components/componentsindex";
import { NFTMarketplaceProvider } from "../Context/NFTMarketplaceContext";
import Head from "next/head";  // Import Head from next/head

const MyApp = ({ Component, pageProps }) => (
  <div>
    <NFTMarketplaceProvider>
      <Head>
        {/* Set the site title */}
        <title>NFT ArtHub</title>
        {/* Set the favicon */}
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <NavBar />
      <Component {...pageProps} />
      <Footer />
    </NFTMarketplaceProvider>
  </div>
);

export default MyApp;
