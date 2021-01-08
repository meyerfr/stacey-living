import React, { Component } from 'react'
import Flatpickr from "react-flatpickr";
import moment from 'moment'



class PersonalDataWrapper extends Component {
  constructor(props){
    super(props)
    this.state = {
      options: {
        altInput: true,
        altFormat: "d.m.Y",
        dateFormat: "Y-m-d",
        placeholder: 'select a Date',
        locale: {
          firstDayOfWeek: 1 // start week on Monday
        },
        maxDate: moment(new Date()).subtract(18, 'years').format(),
        position: "auto center"
      }
    }
  }


  updateApplicant = event => {
    this.props.updateApplicant(event.target.value)
  }

  render() {
    return(
      <div className={`personalData-wrapper ${this.props.hidden}`}>
        <div style={{zIndex: 1, backgroundSize: 'cover', backgroundImage: `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('${this.props.selectedLocation && this.props.selectedLocation.imageUrl}')` }}></div>
        <div className="personalData-form-wrapper">
          <h3 className="underline">When do you want to move?</h3>

          <div className="personalData-form">
            <div className="move-placeholder-wrapper">
              <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="first_name" placeholder=" " />
              <div className="move-placeholder-placeholder">First Name</div>
            </div>

            <div className="move-placeholder-wrapper">
              <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="lasst_name" placeholder=" " />
              <div className="move-placeholder-placeholder">Last Name</div>
            </div>

            <div className="move-placeholder-wrapper">
              <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="email" placeholder=" " />
              <div className="move-placeholder-placeholder">Email</div>
            </div>

            <div>
              <label className="dob">Date of Birth</label>
              <div className="move-placeholder-wrapper">
                <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_day" placeholder=" " />
                <div className="move-placeholder-placeholder">Day</div>
              </div>

              <div className="move-placeholder-wrapper">
                <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_month" placeholder=" " />
                <div className="move-placeholder-placeholder">Month</div>
              </div>

              <div className="move-placeholder-wrapper">
                <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_year" placeholder=" " />
                <div className="move-placeholder-placeholder">Year</div>
              </div>
            </div>

            <div className="move-placeholder-wrapper">
              <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="phone_code" placeholder=" " />
              <div className="move-placeholder-placeholder">Phone Code</div>
            </div>

            <div className="move-placeholder-wrapper">
              <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="phone_number" placeholder=" " />
              <div className="move-placeholder-placeholder">Phonenumber</div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default PersonalDataWrapper;
