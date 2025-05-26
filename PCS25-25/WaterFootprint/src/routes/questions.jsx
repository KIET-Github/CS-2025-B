import { useState } from "react"
import './camera.css'
import { input, prod } from "@tensorflow/tfjs"

function Answer(props){

    const [fetching,setFetching] = useState(true)


    const value = (product,material)=>{
        product = product.toLowerCase()
        material = material.toLowerCase()

        console.log(material,product)
        if(product==="bottle" && material==="plastic"){
            return 100;
        }

        else if(product==="bottle" && material==="steel"){
            return 111.2
        }

        else if(product==="book" && material==="50-100"){
            return 44;
        }

        else if(product==="book" && material==="100-200"){
            return 80
        }

        else if(product==="book" && material==="200+"){
            return 104
        }
    }

    const change = ()=>{
        setFetching(false)
    }

    setTimeout(change,3000)



    if(fetching){
        return(
            <div className="options_box final">
            <h2 className="blue_berry">Loading Data...</h2>
            </div>
        )
    }

    else{
    return(

        <div className="options_box final">
            <h2 className="blue_berry">Water footprint for {props.selectedOption} of {props.selectedoption} is:  {value(props.selectedOption,props.selectedoption)} litres</h2>
            <h3 className="Thanks">Thank You!!</h3>

        </div>
    )
}
}
export default function Questions(props){

    const [submit,setSubmit] = useState(false)
    const [selectedoption, setSelectedoption] = useState("")

    const handleSubmit = (event)=>{
        event.preventDefault();
        setSubmit(true)
    }

    const handleOptionChange = (option)=>{
        setSelectedoption(option)
    }

    const material = (input) =>{
        input = input.toLowerCase();

         if(input==="bottle")
         return ["Plastic","Steel"]

        else if(input==="book" || input==="paper")
        return ["50-100","100-200","200+"]
    }

    const head = (input)=>{
        input = input.toLowerCase()

        if(input ==="bottle")
        return `Choose the material of ${input}`

        else if(input==="book")
        return `How many pages in ${input}`
    }


    

    if(submit){
        return (<Answer selectedoption={selectedoption} selectedOption={props.selectedOption} />)
            }
        
            else{
               const options = material(props.selectedOption)
               const heading = head(props.selectedOption)
              return(

                <div className="options_box">
        
            <h2 className="choose_heading">{heading}:</h2>
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
                      checked={selectedoption === option}
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

