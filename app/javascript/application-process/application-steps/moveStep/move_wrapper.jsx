import React, { Component } from 'react';
import Flatpickr from "react-flatpickr";
import PhoneInput from 'react-phone-number-input'

class MoveWrapper extends Component {
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
        minDate: "today",
        position: "auto center"
      },
      step: 1,
      move_in: '',
      move_out: '',
      first_name: '',
      last_name: '',
      email: '',
      dob_day: '',
      dob_month: '',
      dob_year: '',
      job: '',
      phone_code: '',
      phone_number: ''
    }
  }

  changeMoveIn = (event) => {
    this.setState({
      step: this.state.step + 1,
      move_in: event.target ? event.target.innerText : event[0]
    })
  }

  changeMoveOut = (event) => {
    this.setState({
      step: this.state.step + 1,
      move_out: event.target.innerText
    })
  }

  updateApplicant = event => {
    this.setState({
      [event.target.name]: event.target.value
    })
  }

  finishAppplication = (event) => {
    this.props.changeMoveData(this.state.move_in, this.state.move_out)
  }

  range = (start, end) => {
    return Array(end - start + 1).fill().map((_, idx) => start + idx)
  }

  checkList = event => {
    if (event.target.value.length === 0 || event.target.list.querySelector(`option[value="${event.target.value}"]`) === null) {
      event.target.parentElement.classList.add('error')
    } else{
      event.target.parentElement.classList.remove('error')
    }
  }

  render() {
    console.log(this.state)
    return (
      <div className={`move-wrapper ${this.props.hidden}`}>
        <div style={{backgroundSize: 'cover', backgroundImage: `linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.2)), url('${this.props.selectedLocation && this.props.selectedLocation.imageUrl}')` }}></div>
        <div className={`moveIn-options-wrapper${this.state.step != 1 ? ' hidden' : ''}`}>
          <h3 className="underline">When do you want to move?</h3>
          <div className="moveIn-options">
            <span className="option" onClick={this.changeMoveIn}>As soon as possible</span>
            <span className="option" onClick={this.changeMoveIn}>30 days</span>
            <span className="option" onClick={this.changeMoveIn}>60 days</span>
            <Flatpickr
              placeholder="select a Date"
              options={this.state.options}
              // value={new Date()}
              className='option'
              onChange={this.changeMoveIn}
            />
          </div>
        </div>
        <div className={`moveIn-options-wrapper${this.state.step != 2 ? (this.state.step < 2 ? ' hidden-right' : ' hidden') : ''}`}>
          <h3 className="underline">How long are you going to stay?</h3>
          <div className="moveIn-options">
            <span className="option" onClick={this.changeMoveOut}>3-5 Months</span>
            <span className="option" onClick={this.changeMoveOut}>6-8 Months</span>
            <span className="option" onClick={this.changeMoveOut}>9-12 Months</span>
            <span className="option" onClick={this.changeMoveOut}>Forever</span>
            {
              // <Flatpickr
              //   placeholder="select a Date"
              //   options={this.state.options}
              //   // value={new Date()}
              //   className='option'
              //   onChange={this.changeMoveData}
              // />
            }
          </div>
        </div>
        <div className={`moveIn-options-wrapper personalData-form-wrapper${this.state.step != 3 ? ' hidden-right' : ''}`}>
          <h3 className="underline">Who are you?</h3>

          <div className="personalData-form moveIn-options">
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

            <div className="dob">
              <label className="dob">Date of Birth</label>
              <div className="move-placeholder-wrapper">
                <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" list="dob_days" name="dob_day" onChange={this.updateApplicant} value={this.state.dob_day} placeholder=" " onBlur={this.checkList} />
                <div className="move-placeholder-placeholder">Day</div>
                <datalist id="dob_days">
                  {
                    Array.from(Array(31).keys()).map(i => 1 + i).map((day) => <option key={day} value={day} />)
                  }
                </datalist>
              </div>

              <div className="move-placeholder-wrapper">
                <input list="dob_months" name="dob_month" className="move-placeholder-input" onChange={this.updateApplicant} value={this.state.dob_month} placeholder=" " onBlur={this.checkList} />
                <div className="move-placeholder-placeholder">Month</div>
                <datalist id="dob_months">
                  <option value="January" />
                  <option value="February" />
                  <option value="March" />
                  <option value="April" />
                  <option value="May" />
                  <option value="June" />
                  <option value="July" />
                  <option value="August" />
                  <option value="September" />
                  <option value="October" />
                  <option value="November" />
                  <option value="December" />
                </datalist>
                {
                  // <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_month" placeholder=" " />
                }
              </div>

              <div className="move-placeholder-wrapper">
                <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" list="dob_years" name="dob_year" onChange={this.updateApplicant} value={this.state.dob_year} placeholder=" " onBlur={this.checkList} />
                <div className="move-placeholder-placeholder">Year</div>
                <datalist id="dob_years">
                  {
                    this.range(1950, 2003).map((day) => <option key={day} value={day} />)
                  }
                </datalist>
              </div>
            </div>


            <div className="move-placeholder-wrapper phone">
              <PhoneInput
                defaultCountry="DE"
                placeholder=" "
                className={this.state.phone_number ? '' : ' placeholder-shown'}
                value={this.state.phone_number}
                name="phone_number"
                onChange={value => this.setState({phone_number: value})}
              />
              <div className="move-placeholder-placeholder">Phone Number</div>
              {
                // <input onChange={this.updateApplicant} type="text" className="move-placeholder-input" name="phone_code" placeholder=" " />
              }
            </div>
            <button className="stacey-button reverse-hover apply-button">Apply</button>
          </div>
        </div>
      </div>
    );
  }
}

export default MoveWrapper;
