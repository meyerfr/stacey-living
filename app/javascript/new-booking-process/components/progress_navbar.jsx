import React from 'react'
import staceyLogoPink from '../../../assets/images/stacey_logo_pink.png'

const ProgressNavbar = props => {
  return(
    <nav className="navbar-wrapper">
      {props.children ? props.children : <br/>}
      <ul id="progressbar">
        <li className="active">Choose Location</li>
        <li>Choose Roomtype</li>
        <li>Sign Contract</li>
        <li>Payment Info</li>
      </ul>
      <img src={staceyLogoPink} alt="staceyLogoPink" />
    </nav>
  )
}

export default ProgressNavbar;
