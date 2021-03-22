import React from 'react'
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons'

import staceyLogoPink from '../../../assets/images/stacey_logo_pink.png'

const ProgressNavbar = props => {
  const onClickFunction = (step) => {
    switch(step) {
      case 0:
        return props.history.push(`/bookings/${props.params.booking_auth_token}/${props.params.booking_id}/projects`)
        break;
      case 1:
        return props.history.push(`/bookings/${props.params.booking_auth_token}/${props.params.booking_id}/projects/${props.params.project_id}/roomtypes`)
        break;
      case 2:
        return props.history.push(`/bookings/${props.params.booking_auth_token}/${props.params.booking_id}/projects/${props.params.project_id}/roomtypes/${props.params.roomtype_id}`)
        break;
      case 3:
        return props.history.push(`/bookings/${props.params.booking_auth_token}/${props.params.booking_id}/projects/${props.params.project_id}/roomtypes/${props.params.roomtype_id}/contract`)
        break;
      case 4:
        return props.history.push(`/bookings/${props.params.booking_auth_token}/${props.params.booking_id}/payment`)
        break
    }
  }

  return(
    <nav className="navbar-wrapper">
      {
        props.step > 1 ?
          <div className="prev-button" onClick={() => onClickFunction(props.step - 2)}>
            <FontAwesomeIcon icon={faArrowLeft} />
            Previous
          </div>
        :
          <br />
      }
      <ul id="progressbar">
        <li className={props.step > 0 ? "active" : ''} onClick={() => props.step > 1 ? onClickFunction(0) : undefined}>Choose Location</li>
        <li className={props.step > 1 ? "active" : ''} onClick={() => props.step > 2 ? onClickFunction(props.step > 3 ? 2 : 1) : undefined}>Choose Roomtype</li>
        <li className={props.step > 3 ? "active" : ''} onClick={() => props.step > 4 ? onClickFunction(3) : undefined}>Sign Contract</li>
        <li className={props.step > 4 ? "active" : ''} onClick={() => props.step > 5 ? onClickFunction(4) : undefined}>Payment Info</li>
      </ul>
      <img src={staceyLogoPink} alt="staceyLogoPink" />
    </nav>
  )
}

export default ProgressNavbar;
