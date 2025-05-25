import Navbar from "../components/Navbar";
import React from "react";
import image1 from "../images/21.jpg"
import image2 from "../images/22.jpg"
import image4 from "../images/24.jpg"
import image3 from "../images/23.jpg"
import './explore.css'

export default function Explore(){
    return(
        <>
        <Navbar/>
        <div className="show">
            <h2>How the waterfootprint of diffrent countries is distributed in three categories</h2>
            <img src={image4} width="600px"></img>
            <img src={image1} width="600px"></img>
            <img src={image2} width="600px"></img>
            <img src={image3} width="600px"></img>
            
        </div>
        
        </>
    )
}