import React, { Component } from 'react';
import stacey_logo from '../../../assets/images/stacey_logo_schwarz.png'
import { CSSTransition } from 'react-transition-group';
import { parsePhoneNumber } from 'react-phone-number-input';
import moment from 'moment';

// import GoogleMapReact from 'google-map-react';

import locations from '../locations';
// import LocationList from './location_list';
// import Marker from './marker';

import LocationWrapper from '../application-steps/locationStep/location_wrapper'
import MoveWrapper from '../application-steps/moveStep/move_wrapper'
import PersonalDataWrapper from '../application-steps/personalDataStep/personalData_wrapper'
import FinishModal from './finish_modal'

import {createApplication} from '../actions'

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedLocation: '',
      move_in: '',
      move_out: '',
      first_name: '',
      last_name: '',
      email: '',
      dob_day: '',
      dob_month: '',
      dob_year: '',
      phone_number: '',
      step: 1,
      show: false,
      loading: false,
      locations
    };
  }

  center() {
    return {
      lat: 53.567344,
      lng: 9.988367
    };
  }

  nextStep = () => {
    // window.scroll({
    //   top: 0,
    //   left: 0,
    //   behavior: 'smooth'
    // });
    this.setState({step: this.state.step + 1})
  }

  selectLocation = (index, nextStepBoolean) => {
    nextStepBoolean && this.nextStep();
    this.setState({ selectedLocation: locations[index] });
  }

  changeMoveData = (newMoveInValue, newMoveOutValue) => {
    this.nextStep();
    this.setState({
      move_in: newMoveInValue,
      move_out: newMoveOutValue
    })
  }

  handleResponse = (data) => {
    this.setState({
      // move_in: application_data.move_in,
      // move_out: application_data.move_out,
      // first_name: application_data.first_name,
      // last_name: application_data.last_name,
      // email: application_data.email,
      // dob_day: application_data.dob_day,
      // dob_month: application_data.dob_month,
      // dob_year: application_data.dob_year,
      // phone_number: application_data.phone_number,
      show: true,
      loading: false
    })
  }

  finishAppplication = (application_data) => {
    this.setState({loading: true})

    let phoneNumber = parsePhoneNumber(application_data.phone_number)
    const phoneCode = `+${phoneNumber.countryCallingCode}`
    phoneNumber = phoneNumber.number.slice(phoneCode.length)

    const application = {
      move_in: application_data.move_in,
      move_out: application_data.move_out,
      prefered_location: this.state.selectedLocation.name,
      user_attributes: {
        first_name: application_data.first_name,
        last_name: application_data.last_name,
        email: application_data.email,
        phone_code: phoneCode,
        phone_number: phoneNumber,
        dob: moment(`${application_data.dob_day}.${application_data.dob_month}.${application_data.dob_year}`).format()
      }
    }

    createApplication(application, this.handleResponse)

    // createApplication(
    //   application
    //   // setTimeout(() => {
    //   //   window.location.href = "https://www.stacey.de/faq";
    //   // }, 30000)
    // )
  }

  myDisplayer = (some) => {
    document.getElementById("demo").innerHTML = some;
  }

  render() {
    const step = this.state.step
    const steps = [
      { number: 1, name: 'location', timeout: { appear: 1000, enter: 1000, exit: 1000 }, component: <LocationWrapper locations={locations} selectedLocation={this.state ? this.state.selectedLocation : locations[0]} selectLocation={this.selectLocation} /> },
      { number: 2, name: 'bookingData', timeout: { appear: 1000, enter: 250, exit: 1000 }, component: <MoveWrapper selectedLocation={this.state ? this.state.selectedLocation : locations[0]} changeMoveData={this.changeMoveData} finishAppplication={this.finishAppplication} loading={this.state.loading} /> }
    ]

    return (
      <div className="application-wrapper">
        <img src={stacey_logo}
          alt="logo"
          className="logo"
          style={{
            height: '30px',
            position: 'absolute',
            zIndex: '100',
            top: '10px',
            left: '10px'
          }}
        />
        {
          steps.map(({ number, name, timeout, component}) => (
            <CSSTransition
              unmountOnExit
              in={this.state.step == number}
              timeout={{ appear: 1000, enter: 250, exit: 1000 }}
              classNames='slide'
              key={number}
              // appear
            >
              {component}
            </CSSTransition>
          )
        )}
        <FinishModal applicant={this.state} show={this.state.show}></FinishModal>
      </div>
    );
  }
}

export default App;
