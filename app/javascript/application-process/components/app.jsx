import React, { Component } from 'react';
// import GoogleMapReact from 'google-map-react';

import locations from '../locations';
// import LocationList from './location_list';
// import Marker from './marker';

import LocationWrapper from '../application-steps/locationStep/location_wrapper'
import MoveWrapper from '../application-steps/moveStep/move_wrapper'
import PersonalDataWrapper from '../application-steps/personalDataStep/personalData_wrapper'

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      selectedLocation: null,
      move_in: '',
      move_out: '',
      first_name: '',
      last_name: '',
      email: '',
      dob_day: null,
      dob_month: null,
      dob_year: null,
      job: '',
      phone_code: '',
      phone_number: '',
      step: 1,
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

  render() {
    console.log(this.state)
    const step = this.state.step
    return (
      <div className="application-wrapper">
        <LocationWrapper
          locations={this.state.locations}
          selectedLocation={this.state.selectedLocation}
          selectLocation={this.selectLocation}
          hidden={this.state.step != 1}
        />

        <MoveWrapper
          selectedLocation={this.state.selectedLocation}
          move_in={this.state.move_in}
          hidden={step != 2 ? (step < 2 ? 'hidden-right' : 'hidden') : 'show'}
          changeMoveData={this.changeMoveData}
          moveStep={this.state.moveStep}
        />
        {

        // <PersonalDataWrapper
        //   first_name={this.state.first_name}
        //   last_name={this.state.last_name}
        //   email={this.state.email}
        //   phone_code={this.state.phone_code}
        //   phone_number={this.state.phone_number}
        //   dob_day={this.state.dob_day}
        //   dob_month={this.state.dob_month}
        //   dob_year={this.state.dob_year}
        //   selectedLocation={this.state.selectedLocation}
        //   hidden={step != 3 ? (step < 3 ? 'hidden-right' : 'hidden') : 'show'}
        // />
          // <LocationList
          //   locations={this.state.locations}
          //   selectedLocation={this.state.selectedLocation}
          // />
          // <div className="map-container">
          //   <GoogleMapReact
          //     defaultCenter={this.center()}
          //     defaultZoom={13}
          //     bootstrapURLKeys={{ key: 'AIzaSyBCw-g1ofOTPw7H6Ub1wAe5cFSheaw-k7c' }}
          //   >
          //     {
          //       this.state.locations.map((location) => {
          //         return <Marker key={location.name} lat={location.lat} lng={location.lng} />
          //       })
          //     }
          //   </GoogleMapReact>
          // </div>
        }
      </div>
    );
  }
}

export default App;
