import { Routes,Route } from 'react-router-dom';
import './styles.css';
import Home from './routes/home.jsx';
import About from './routes/about.jsx';
import Calculator from './routes/Calculator.jsx';
import Explore from './routes/Explore.jsx';
import Contact from './routes/contact.js';
import Camera from './routes/camera';
import Result from './routes/result'


function App() {
  return(
    <>
        <Routes>
            <Route path='/' element={<Home/>}></Route>
            <Route path='/explore' element={<Explore/>}></Route>
            <Route path='/about' element={<About/>}></Route>
            <Route path='/contact' element={<Contact/>}></Route>
            <Route path='/calculator' element={<Calculator/>}></Route>
            <Route path='/camera' element={<Camera/>}></Route>  
            <Route path='/result' element={<Result/>}></Route>            
        </Routes>
        </>
  );
}

export default App;
