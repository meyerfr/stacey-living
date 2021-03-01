import React from 'react'
import staceyLogoPink from '../../../assets/images/stacey_logo_pink.png'

const ProgressNavbar = props => {
  return(
    <nav className="navbar-wrapper">
      {props.children ? props.children : <br/>}
      <ul id="progressbar">
        <li className={props.step > 0 ? "active" : ''}>Choose Location</li>
        <li className={props.step > 1 ? "active" : ''}>Choose Roomtype</li>
        <li className={props.step > 2 ? "active" : ''}>Sign Contract</li>
        <li className={props.step > 3 ? "active" : ''}>Payment Info</li>
      </ul>
      <img src={staceyLogoPink} alt="staceyLogoPink" />
    </nav>
  )
}

export default ProgressNavbar;
