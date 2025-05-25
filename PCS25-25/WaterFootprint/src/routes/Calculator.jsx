import Navbar from "../components/Navbar";
import React from "react";
import image1 from "../images/5.jpg"
import './calculator.css'
import { useState } from "react";
import InputForm from "../components/form";


export default function Calculator(){
    return(
        <>
        <Navbar/>
            <div className="calculate">
                <img src={image1} alt="" width='1270px'/>
                <div className="page">
                 <h1>Personal water footprint calculator</h1>
                 <h3 >What’s the water footprint of your current lifestyle? You might be surprised!</h3>
                 <h5>Based on your country of residence and your own consumption pattern, you will have a unique water footprint. Please feel free to use the footprint calculator to assess your own water footprint.</h5>
                
                {/* <Form/> */}
                <InputForm/>
            </div>
            </div>
                
            
          
        
        </>
    )
}