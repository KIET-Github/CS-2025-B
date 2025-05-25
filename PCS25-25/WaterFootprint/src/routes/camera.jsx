// // import React, { useState,useEffect } from 'react';
// // import { useRef } from 'react';
// // import Webcam from 'react-webcam';
// // const Camera = () => {
// //   const webcamRef = useRef(null);



// //   return (
// //     <div>
// //       <h2>Show the objects in your camera for which you want to calculate the water footprint</h2>
// //       <Webcam
// //         // Set to true if you want to include audio from the microphone
// //         ref={webcamRef}
// //         // You can change the format if needed
// //       />
// //     </div>
// //   );
// // };

// Import dependencies
import React, { useRef, useState, useEffect } from "react";
import * as tf from "@tensorflow/tfjs";
import * as cocossd from "@tensorflow-models/coco-ssd";
import Webcam from "react-webcam";
// import "./App.css";
import { drawRect , detected_objects } from "./utilities";
import './camera.css'
import Navbar from "../components/Navbar";
import { Link } from "react-router-dom";
import Questions from "./questions";
// function Answer(props){

//   const find_array=()=>{

//   }

//   const options = find_array();
//   return(
//     <>
//     <form className="options" onSubmit={handleSubmit}>

// <div className="box_input">
//   <div className="one_more">
// {options.map((option, index) => (
//   <div key={index}>
//     <input
//       type="radio"
//       id={`control_${index}`}
//       name="select"
//       value={index}
//       checked
//       // checked={/* You need to provide a condition to check if this radio button is selected */}
//       onChange={() => handleOptionChange(index)} // You should provide a function to handle the radio button change
//     />
//     <label htmlFor={`control_${index}`}>{option}</label>
//     </div>
  
// ))}
// </div>
// </div>
// <button className = "submit" type="submit">Submit</button>
// </form>

//     </>
//   )
// }



function Options(props){

  const [submitted, setSubmitted] = useState(false);


  const remove_elements = (arr) =>{
    // console.log
    while(arr.length){
      arr.pop()
    }
  }

 const detected_objects = props.detected_objects
 const options = Array.from(detected_objects)
//  detected_objects = Array.from(props)
//  console.log(`this is the main line:" ${options}`)

  const [selectedOption, setSelectedOption] = useState("");

  // Handler function for option change
  const handleOptionChange = (option) => {
    setSelectedOption(option);
    console.log("choosen:",option)
  };

  // Handler function for form submission
  const handleSubmit = (event) => {
    event.preventDefault();
    // Do something with the selected option, e.g., send to server
    setSubmitted(true)
    console.log("Selected Option:", selectedOption);
    console.log(selectedOption)

    remove_elements(options)
    // remove_elements(detected_objects)
    detected_objects.clear()

    
    console.log(detected_objects)


  };

  const renderComponent = () =>{
    if(submitted){
return (<Questions selectedOption={selectedOption} />)
    }

    else{
      return(
        <div className="options_box">

    <h2 className="choose_heading">Choose any one:</h2>
        <form className="options" onSubmit={handleSubmit}>

        <div className="box_input">
          <div className="one_more">
        {options.map((option, index) => (
          <div key={index}>
            <input
              type="radio"
              id={`control_${index}`}
              name="select"
              value={option}
              checked={selectedOption === option}
              // checked={/* You need to provide a condition to check if this radio button is selected */}
              onChange={() => handleOptionChange(option)} // You should provide a function to handle the radio button change
            />
            <label htmlFor={`control_${index}`}>{option}</label>
            </div>
          
        ))}
        </div>
        </div>
        <button className = "submit" type="submit">Submit</button>
      </form>
      </div>
      )
    }
  }

  return (

    
    renderComponent()
    






  )
     
}




function Camera(){
  const webcamRef = useRef(null);
  const canvasRef = useRef(null);

  const [detecting,setDetecting] = useState(true)
  const [intervalId, setIntervalId] = useState(null);
  // const [product,setProduct] = useState(false)
  // const [questions,setQuestions] = useState(false)
  // const [answer,setAnswer] = useState(false)


  const stopped = () =>{


    setDetecting(false)

    clearInterval(intervalId)

    // const array = Array.from(detected_objects)
    console.log(detecting)
    console.log(detected_objects)
}

  const runCoco = async () => {
    const net = await cocossd.load();
    console.log("Handpose model loaded.");
    
    
   const id =  setInterval(() => {  
    
    if(detecting){
      console.log("suraj")
detect(net);
    }
    


    }, 10);

    setIntervalId(id)

    // setDetecting((prev) => ({ ...prev, stop_function }));

  };

  const detect = async (net) => {
    // Check data is available
    if (
      typeof webcamRef.current !== "undefined" &&
      webcamRef.current !== null &&
      webcamRef.current.video.readyState === 4
    ) {
      // Get Video Properties
      const video = webcamRef.current.video;
      const videoWidth = webcamRef.current.video.videoWidth;
      const videoHeight = webcamRef.current.video.videoHeight;

      // Set video width
      webcamRef.current.video.width = videoWidth;
      webcamRef.current.video.height = videoHeight;

      // Set canvas height and width
      canvasRef.current.width = videoWidth;
      canvasRef.current.height = videoHeight;

      // Make Detections
      const obj = await net.detect(video);

      // Draw mesh
      const ctx = canvasRef.current.getContext("2d");
      
      drawRect(obj, ctx); 
    }
  };

  


useEffect(()=>{runCoco();
    return ()=>{
         clearInterval(intervalId)
    }
},[detecting]);

  return (
    <>

      <Navbar/>

      <div className="camera">

      <div className="App-header">
        <Webcam
          ref={webcamRef}
          muted={true} 
          style={{
            position: "absolute",
            marginLeft: "auto",
            marginRight: "auto",
            left: 100,
            right: 0,
            textAlign: "center",
            zindex: 9,
            width: 640,
            height: 420,
          }}
        />

        <canvas
          ref={canvasRef}
          style={{
            position: "absolute",
            marginLeft: "auto",
            marginRight: "auto",
            left: 100,
            right: 0,
            textAlign: "center",
            zindex: 8,
            width: 640,
            height: 460,
          }}
        />
      </div>

</div>

   { detecting && <div className="camera_heading">Show the objects of which you want to calculate the water footprint</div>}
    <button className="stop" onClick={stopped}>Stop scanning</button>

    { !detecting && <Options detected_objects = {detected_objects}/>}
    </>

    
  );
}

export default Camera;

// <div className="suraj">surajjain</div>
    // <form className = "options" onSubmit={handleSubmit}>
    //   <label>
    //     Select an option:
    //     <select value={selectedOption} onChange={handleOptionChange}>
    //       <option value="">Select...</option>
    //       {options.map((option, index) => (
    //         <option key={index} value={option}>
    //           {option}
    //         </option>
    //       ))}
    //     </select>
    //   </label>

    //   <button type="submit" >Submit</button>
    // </form>