import Navbar from "../components/Navbar"
import './home.css';
import image from '../images/3.jpg'
import image1 from '../images/11.png'
import image2 from '../images/12.png'
import image3 from '../images/13.png'
// import main_image from '../images/main.jpg'
import { Link } from "react-router-dom";
import Footer from '../components/footer'
// import Calculate from
{/* <script src="https://kit.fontawesome.com/1ad6e9d079.js" crossorigin="anonymous"></script> */}
// import { FontAwesomeIcon } from 'https://kit.fontawesome.com/1ad6e9d079.js';

function Save(){
    return(
        <>
        <div className="save">
            <div className="heading-save">SAVE</div>
            <div className="save-des">Ever thought about H2O waterfootprint? Our cutting edge calculator reveals the start link truth about water usage!. Dont drown in guilt, Take a dive into water conversation today!
            </div>
        </div>
        </>
    )
}

function Strap(props){
    return(
        <div className="line">
            <img src={props.url} alt="" />
            <h4 className="title">{props.title}</h4>
            {/* <FontAwesomeIcon icon="fa-solid fa-arrow-right" /> */}
        </div>
    );
}

function Dive(){
    return(
        <div className="divee">
        <div className="dive-main">
            <div className="dive-heading">Dive In</div>
            <div className="dive-des">Ready to make waves on your water journey? Give our calculator a whirl and uncover your water footprint. The planet needs more water heroes like you!</div>
            <div className="btns">
                <div className="box">
                    <h4 className="box-des">Calculate your waterfootprint just by giving some inputs about yourself</h4>
                    <Link to = "/calculator"><button>Calculate</button></Link>
                </div>

                <div className="box">
                    <h4 className="box-des">Calculate the waterfootprint of any product just by scanning through it your camera</h4>
                    <Link to = "/camera"><button>Scan</button></Link>
                </div>
            </div>
        </div>
        </div>
    )
}
export default function Home(){
    return(
        <>
        <Navbar/>
        <div className="image">
            
            <img src={image} alt=""  className="full-width-image" height="670px"/>
            <div className="main">
            <div className="des">
                Learn All About : Water Footprint
            </div>
        </div>
       
        </div>

        <Save/>

        <div className="three">
        < Strap title="Easy interface" url={image3} />
        < Strap title="Fast Result" url={image2} />
        < Strap title="Conscious Community" url={image1} />

        </div>

        <Dive/>
        <Footer/>
              </>
    )
}