import React, { Component } from 'react'
import moment from 'moment'

export default class UserSummary extends Component {
  renderRadioField = (gender) => {
    const currentGender = this.props.user.gender
    return(
      <div className="gender-input">
        <input type="radio" id={gender} key="genderInput" name="gender" value={gender} onChange={() => this.props.updateGender(gender)} checked={currentGender === gender}/>
        <label className="label" htmlFor={gender} key="genderLabel">{gender}</label>
      </div>
    )
  }

  render() {
    const user = this.props.user
    return[
      <h3 key="rightSzeneHeader" className="szene-header header-margin">Personal Information</h3>,
      <div key="rightSzeneList" className="user-info-list">
        <div className="user-info-item">
          <span className="label">First Name</span>
          <span className="value">{user.first_name}</span>
        </div>
        <div className="user-info-item">
          <span className="label">Last Name</span>
          <span className="value">{user.last_name}</span>
        </div>
        <div className="user-info-item">
          <span className="label">Email</span>
          <span className="value">{user.email}</span>
        </div>
        <div className="user-info-item">
          <span className="label">Phonenumber</span>
          <span className="value">{`${user.phone_code} ${user.phone_number}`}</span>
        </div>
        <div className="user-info-item">
          <span className="label">Gender</span>
          {this.renderRadioField('male')}
          {this.renderRadioField('female')}
          {this.renderRadioField('diverse')}
        </div>

        <div className="user-info-item">
          <span className="label">Date of Birth</span>
          <span className="value">{moment(user.dob).format('DD/MM/YYYY')}</span>
        </div>
      </div>
    ]
  }
}
