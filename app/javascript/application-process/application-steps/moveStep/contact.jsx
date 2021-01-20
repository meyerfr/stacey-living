import React, { Component } from 'react';
import PhoneInput from 'react-phone-number-input';
import { CSSTransition } from 'react-transition-group';
import Spinner from 'react-bootstrap/Spinner';


class Contact extends Component{
  constructor(props) {
    super(props)
    this.state = {
      applicant: {
        first_name: '',
        last_name: '',
        email: '',
        dob_day: '',
        dob_month: '',
        dob_year: '',
        phone_number: '',
      },
      buttonDisabled: true,
      errors: {}
    }
  }

  updateApplicant = event => {
    console.log(event)
    let applicant = this.state.applicant
    if (event && event.target) {
      applicant[event.target.name] = event.target.value
      this.setState({
        applicant
      })
    }else{
      applicant['phone_number'] = event
      this.setState({
        applicant
      })
    }
  }

  validate = event => {
    let field = event.target.name
    let error_message = this.validateField(field, this.state.applicant[field])
    let errors = this.state.errors
    if (error_message) {
      errors[field] = error_message
    } else{
      delete errors[field]
    }
    this.setState({
      errors: errors
    })
  }

  validateField = (field, value) => {
    let error_message = ''

    switch(field) {
      case 'first_name': case 'last_name': case 'phone_number':
        if (!value) {
          error_message = `Please enter your ${field.replace('_', ' ')}`
          // buttonDisabled = true
        }
        break;
      case 'dob_year':
        if (!value || value != this.range(new Date().getFullYear()-65, new Date().getFullYear()-18).find(year => year == value)) {
          error_message = `invalid`
          // buttonDisabled = true
        }
        break;
      case 'dob_day':
        if (!value || value != this.range(1, 31).find(day => day == value)) {
          error_message = `invalid`
          // buttonDisabled = true
        }
        break;
      case 'dob_month':
        if (!value || document.getElementById('dob_months').querySelector(`option[value="${value}"]`) === null) {
          error_message = (field == 'dob_month' ? 'Choose Month from the List' : 'invalid')
          // buttonDisabled = true
        }
        break;
      case 'email':
        let pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
        if (!value) {
          error_message = "Please enter your email address.";
          // buttonDisabled = true
        } else if (!pattern.test(value)) {
          error_message = "Please enter valid email address.";
          // buttonDisabled = true
        }
        break;
    }

    return error_message;
  }

  validateAll = () => {
    let applicant = this.state.applicant
    Object.keys(applicant).map((field) => {
      let error_message = this.validateField(field, applicant[field])
      if (error_message) {
        let errors = this.state.errors
        errors[field] = error_message
        this.setState({
          errors: errors
        })
      }
    })

    return Object.keys(this.state.errors).length == 0;
  }

  // updateApplicantPhone = event => {
  //   const value = event.target.value
  //   let phoneNumber = value != '' && value != null && parsePhoneNumber(value)
  //   console.log(phoneNumber)
  //   let countryCode = null
  //   if (phoneNumber) {
  //     countryCode = `+${phoneNumber.countryCallingCode}`
  //     phoneNumber = phoneNumber.number.slice(countryCode.length)
  //   }

  //   if (phoneNumber && countryCode) {
  //     this.setState({
  //       phone_number: phoneNumber,
  //       phone_code: countryCode
  //     })
  //   } else{
  //     this.setState({
  //       phone_number: value
  //     })
  //   }
  // }

  range = (start, end) => {
    return Array(end - start + 1).fill().map((_, idx) => start + idx)
  }

  checkErrors = () => {
    Object.values(this.state).some(field => (field === '' || field === null || field === undefined)) ?
      this.setState({errors: true})
    :
      this.setState({errors: false})
  }

  finishAppplication = () => {
    if (this.validateAll()) {
      // const {errors, ...applicant} = this.state
      const applicant = this.state.applicant
      this.props.finishAppplication(applicant)
    }
  }


  render() {
    // const {errors, ...applicant} = this.state
    const applicant = this.state.applicant
    const errors = this.state.errors
    console.log(this.state)
    return (
      <div className="step-container moveIn-options-wrapper">
        <h3 className="underline step-header">Who are you?</h3>

        <div className="personalData-form step-form-container">
          <div className="move-placeholder-wrapper step-form-item">
            <input onChange={this.updateApplicant} type="text" value={applicant.first_name} className="move-placeholder-input" name="first_name" placeholder=" " onBlur={this.validate} />
            <div className="move-placeholder-placeholder">First Name</div>
            {errors.first_name && <div className="move-placeholder-error">{errors.first_name}</div>}
          </div>

          <div className="move-placeholder-wrapper step-form-item">
            <input onChange={this.updateApplicant} value={applicant.last_name} type="text" className="move-placeholder-input" name="last_name" placeholder=" " onBlur={this.validate} />
            <div className="move-placeholder-placeholder">Last Name</div>
            {errors.last_name && <div className="move-placeholder-error">{errors.last_name}</div>}
          </div>

          <div className="move-placeholder-wrapper step-form-item">
            <input onChange={this.updateApplicant} value={applicant.email} type="text" className="move-placeholder-input" name="email" placeholder=" " onBlur={this.validate} />
            <div className="move-placeholder-placeholder">Email</div>
            {errors.email && <div className="move-placeholder-error">{errors.email}</div>}
          </div>

          <div className="dob">
            <label className="dob">Date of Birth</label>
            <div className="move-placeholder-wrapper step-form-item">
              <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_day" onChange={this.updateApplicant} value={applicant.dob_day} placeholder=" " onBlur={this.validate} />
              <div className="move-placeholder-placeholder">Day</div>
              {errors.dob_day && <div className="move-placeholder-error">{errors.dob_day}</div>}
            </div>

            <div className="move-placeholder-wrapper step-form-item">
              <input list="dob_months" name="dob_month" className="move-placeholder-input" onChange={this.updateApplicant} value={applicant.dob_month} placeholder=" " onBlur={this.validate} />
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
              {errors.dob_month && <div className="move-placeholder-error">{errors.dob_month}</div>}
            </div>

            <div className="move-placeholder-wrapper step-form-item">
              <input onChange={this.updateApplicant} type="number" className="move-placeholder-input" name="dob_year" onChange={this.updateApplicant} value={applicant.dob_year} placeholder=" " onBlur={this.validate} />
              <div className="move-placeholder-placeholder">Year</div>
              {errors.dob_year && <div className="move-placeholder-error">{errors.dob_year}</div>}
            </div>
          </div>


          <div className="move-placeholder-wrapper phone step-form-item">
            <PhoneInput
              defaultCountry="DE"
              placeholder=" "
              className={applicant.phone_number ? '' : ' placeholder-shown'}
              value={applicant.phone_number}
              name="phone_number"
              onChange={this.updateApplicant}
              onBlur={this.validate}
            />
            <div className="move-placeholder-placeholder">Phone Number</div>
            {errors.phone_number && <div className="move-placeholder-error">{errors.phone_number}</div>}
          </div>
          <button onClick={this.finishAppplication} className="stacey-button reverse-hover apply-button step-form-item step-form-action">
            {
              this.props.loading ?
                <div className="spinner">
                  <Spinner animation="border" role="status">
                    <span className="sr-only">Loading...</span>
                  </Spinner>
                </div>
              :
                'Apply'
            }
          </button>
        </div>
      </div>
    );
  }
}

export default Contact;
