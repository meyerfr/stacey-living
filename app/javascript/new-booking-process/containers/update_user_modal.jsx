import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import Modal from 'react-bootstrap/Modal'
import PhoneInput, { parsePhoneNumber } from 'react-phone-number-input';
import moment from 'moment'

import { updateUser } from '../actions';

class UpdateUserModal extends Component {
  constructor(props) {
    super(props)
    this.state = {
      loading: false,
      errors: {}
    }
  }

  componentDidMount() {
    let user = this.props.user
    if (user) {
      user = {
        ...user,
        'dob_day': user.dob ? moment(user.dob).format('D') : '',
        'dob_month': user.dob ? moment(user.dob).format('MMMM') : '',
        'dob_year': user.dob ? moment(user.dob).format('Y') : ''
      }
      this.setState({
        user: user
      })
    }
  }

  updateUser = (event) => {
    const target_name = (event && event.target) ? event.target.name : 'phone_number'
    const target_value = (event && event.target) ? event.target.value : event
    this.setState({
      user: {
        ...this.state.user,
        [target_name]: target_value
      }
    })
  }

  finishUserUpdate = () => {
    this.setState({
      loading: true
    }, () => {
      let user = this.state.user
      let phoneNumber = parsePhoneNumber(user.phone_code ? `${user.phone_code}${user.phone_number}` : user.phone_number)
      const phoneCode = `+${phoneNumber.countryCallingCode}`
      phoneNumber = phoneNumber.number.slice(phoneCode.length)
      const dob = moment(`${user.dob_day}.${user.dob_month}.${user.dob_year}`).format()
      user = {
        ...user,
        'phone_code': phoneCode,
        'phone_number': phoneNumber,
        dob: dob
      }
      this.props.updateUser(user, () => this.props.closeModal(() => {
        this.setState({
          loading: false
        })
      }))
    })
  }

  range = (start, end) => {
    return Array(end - start + 1).fill().map((_, idx) => start + idx)
  }

  validate = event => {
    let field = event.target.name
    let error_message = this.validateField(field, this.state.user[field])
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

  render() {
    const user = this.state.user
    const errors = this.state.errors
    return (
      <Modal
        show={this.props.show}
        onHide={this.props.closeModal}
        // backdrop="static"
        size="lg"
        aria-labelledby="contained-modal-title-vcenter"
        centered
      >
        {user &&
          <div className="update-user-modal">
            <div className="update-user-modal-head">
              <h1>Update Personal Info</h1>
            </div>
            {
              user &&
              <div className="update-user-modal-body">
                <div className="move-placeholder-wrapper step-form-item">
                  <input onChange={this.updateUser} type="text" value={user.first_name} className="move-placeholder-input" name="first_name" placeholder=" " onBlur={this.validate} />
                  <div className="move-placeholder-placeholder">First Name</div>
                  {errors.first_name && <div className="move-placeholder-error">{errors.first_name}</div>}
                </div>

                <div className="move-placeholder-wrapper step-form-item">
                  <input onChange={this.updateUser} value={user.last_name} type="text" className="move-placeholder-input" name="last_name" placeholder=" " onBlur={this.validate} />
                  <div className="move-placeholder-placeholder">Last Name</div>
                  {errors.last_name && <div className="move-placeholder-error">{errors.last_name}</div>}
                </div>

                <div className="move-placeholder-wrapper step-form-item">
                  <input onChange={this.updateUser} value={user.email} type="text" className="move-placeholder-input" name="email" placeholder=" " onBlur={this.validate} />
                  <div className="move-placeholder-placeholder">Email</div>
                  {errors.email && <div className="move-placeholder-error">{errors.email}</div>}
                </div>

                <div className="dob">
                  <label className="dob">Date of Birth</label>
                  <div className="move-placeholder-wrapper step-form-item">
                    <input onChange={this.updateUser} type="number" className="move-placeholder-input" name="dob_day" onChange={this.updateUser} value={user.dob_day ? user.dob_day : ''} placeholder=" " onBlur={this.validate} />
                    <div className="move-placeholder-placeholder">Day</div>
                    {errors.dob_day && <div className="move-placeholder-error">{errors.dob_day}</div>}
                  </div>

                  <div className="move-placeholder-wrapper step-form-item">
                    <input list="dob_months" name="dob_month" className="move-placeholder-input" onChange={this.updateUser} value={user.dob_month ? user.dob_month : ''} placeholder=" " onBlur={this.validate} />
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
                    <input onChange={this.updateUser} type="number" className="move-placeholder-input" name="dob_year" value={user.dob_year ? user.dob_year : ''} placeholder=" " onBlur={this.validate} />
                    <div className="move-placeholder-placeholder">Year</div>
                    {errors.dob_year && <div className="move-placeholder-error">{errors.dob_year}</div>}
                  </div>
                </div>


                <div className="move-placeholder-wrapper phone step-form-item">
                  <PhoneInput
                    defaultCountry="DE"
                    placeholder=" "
                    className={user.phone_number ? '' : ' placeholder-shown'}
                    value={user.phone_number ? user.phone_number : ''}
                    name="phone_number"
                    onChange={this.updateUser}
                    onBlur={this.validate}
                  />
                  <div className="move-placeholder-placeholder">Phone Number</div>
                  {errors.phone_number && <div className="move-placeholder-error">{errors.phone_number}</div>}
                </div>
              </div>
            }
            <div className="update-user-modal-actions">
              <button className="stacey-button reverse-hover" onClick={this.finishUserUpdate}>{this.state.loading ? 'Loading' : 'Save'}</button>
            </div>
          </div>
        }
      </Modal>
    )
  }
};

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ updateUser }, dispatch);
}


function mapStateToProps(state) {
  return {
    user: state.booking.user
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(UpdateUserModal);
