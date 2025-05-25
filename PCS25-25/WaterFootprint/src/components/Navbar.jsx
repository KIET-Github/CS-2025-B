import React from "react";
import './Navbar.css';
import {Multiitems} from './Multiitems.js'
import { Link } from "react-router-dom";
import  image from '../images/sih_logo.png';

function Navbar(){
     return(
        <>
        <div className="nav-bar">
         <div className="navbar-left">
            <img src={image} alt="logo"  height="40px"></img>
            <h2 className="heading">WaterFootprint</h2>
         </div>

         <div className="navbar-right">
            <ul>
            { Multiitems.map((item,index)=>{
                return(
                  <li key={index} >
                  <Link className={item.cname} to={item.url}>{item.Title}</Link>         
                </li>
                )
             })}

             <select className="language">
             <option value="English">English</option>
             <option value="Hindi">Hindi</option>
             <option value="Telugu">Punjabi</option>
             <option value="Punjabi">Telugu</option>
             </select>
            </ul>
         </div>
         </div>

         
         </>
     );
}

export default Navbar;