import React, { Component } from 'react'
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import Modal from 'react-bootstrap/Modal'
import moment from 'moment'

import {createBooking} from '../actions'

class UserModal extends Component {
  constructor(props) {
    super(props);
    this.state = {
      inviteSend: false
    }
  }

  // inviteSend = () => {
  //   this.setState({inviteSend: true})
  // }

  inviteToBookingProcess = event => {
    // modal should not be closed only react state should change.
    this.props.createBooking(this.props.user.id)

    // const url = `http://localhost:3000/api/v1/users/${this.props.user.id}/bookings`;
    // const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    // const promise = fetch(url, {
    //   method: 'POST',
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'X-CSRF-Token': csrfToken
    //   }
    // }).then(response => response.json())
    //   .then(data => this.inviteSend())
  }

  render() {
    const user = this.props.user
    return(
      <Modal
        show={this.props.visible}
        size="lg"
        onHide={this.props.onHide}
        aria-labelledby="contained-modal-title-vcenter"
        centered
        >
        <div className="modal-container">
          <button className="closeModalButton" onClick={() => this.closeModal()}>Close</button>
          <div className="modal-header">
            <h1 id="modal-title">{user.full_name}</h1>
          </div>
          <div className="modal-body">
            {
              this.state.edit ?
                <button className="fixButton d-none" onClick={this.handleSave}>Save</button>
              :
                <button className="fixButton d-none" onClick={() => this.setState({edit: true})}>Edit</button>
            }
            <table className="modal-content">
              <tbody>
                <tr>
                  <td>Name:</td>
                  <td>{user.full_name}</td>
                </tr>
                <tr>
                  <td>Email:</td>
                  <td><a href={`mailto:${user.email}`}>{user.email}</a></td>
                </tr>
                <tr>
                  <td>Phone:</td>
                  <td>
                    <a href={`tel:${user.phone_code}${user.phone_number}`}>
                      {
                        `${user.phone_code} ${user.phone_number}`
                      }
                    </a>
                  </td>
                </tr>
                {
                  user.booking ?
                    [
                      <tr key="1">
                        <td>Last invite send on the</td>
                        <td>{moment(user.booking.created_at).format('DD/MM/YYYY')}</td>
                      </tr>,
                      <tr key="2">
                        <td>Move in:</td>
                        <td>{user.booking.move_in}</td>
                      </tr>,
                      <tr key="3">
                        <td>Move out:</td>
                        <td>{user.booking.move_out}</td>
                      </tr>,
                      <tr key="4">
                        <td>Booking ID:</td>
                        <td><a href={`/bookings/${user.booking.booking_auth_token}/${user.booking.id}/projects`} className="bookingProcess">{user.booking.id}</a></td>
                      </tr>,
                      <tr key="5">
                        <td>

                        </td>
                      </tr>,
                    ]
                  :
                    [
                      <tr key="1">
                        <td>Applied on the</td>
                        <td>{moment(user.application.created_at).format('DD/MM/YYYY')}</td>
                      </tr>,
                      <tr key="2">
                        <td>Wants to move in:</td>
                        <td>{user.application.move_in}</td>
                      </tr>,
                      <tr key="3">
                        <td>Wants to move out:</td>
                        <td>{user.application.move_out}</td>
                      </tr>,
                    ]
                }
                <tr>
                  <td>User Id:</td>
                  <td>{user.id}</td>
                </tr>
              </tbody>
            </table>
            <div className="button-container">
              {
                // if (user.invited) {
                  // show when invited, (Email state, example: 2nd reminder already Send)
                  // if 2nd reminder already Send give possibility to invite again.
                // } else{
                  // show invite to Booking Process button.
                    // this button calls action -> Invite to Booking process and has updates the User in the Redux state to invite = true
                // }
                <button className="stacey-button" onClick={this.inviteToBookingProcess}>{user.invite_send ? 'Invite again' : 'Invite to Booking process'}</button>
              }
            </div>
          </div>
        </div>
      </Modal>
    )
  }
}

function mapStateToProps(state) {
  return {
    users: state.users
  };
}


function mapDispatchToProps(dispatch) {
  return bindActionCreators({ createBooking }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(UserModal);

