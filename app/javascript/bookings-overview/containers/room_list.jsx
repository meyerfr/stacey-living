import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import ListItem from './list_item'
import { setSortParams, applyFilter } from '../actions';
import { updateBooking } from '../../booking-process/actions'
import Modal from 'react-awesome-modal'
import moment from 'moment'

class RoomList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      visible: false,
      booking: null
    }
  }

  openModal = (booking) => {
    this.setState({
      visible: true,
      booking: booking
    })
  }

  closeModal = () => {
    this.setState({
      visible: false,
      booking: null,
      edit: false
    })
  }

  handleHeaderClick = (sortKey) => {
    let currentlyActiveSortedHeader = event.target.parentElement.querySelector('.active');
    if (currentlyActiveSortedHeader && event.target != currentlyActiveSortedHeader) {
      currentlyActiveSortedHeader.classList.remove('active')
    }
    this.props.setSortParams(sortKey);
    event.target.classList.add('active');
  }

  handleChange = (event) => {
    if (window.confirm(`Are you sure you wish to change the booking state to ${event.target.selectedOptions[0].value}?`)){
      console.log(event.target.selectedOptions[0].value)
      let booking = {
        state: event.target.selectedOptions[0].value
      }
      this.props.updateBooking(
        this.state.booking.id,
        booking
      )
    }
  }

  handleSave = (event) => {
    if (window.confirm(`Are you sure you wish to update the User properties?`)){
      let booking = {
        move_in: this.state.booking.move_in,
        move_out: this.state.booking.move_out,
        phone_number: this.state.booking.phone_number,
      }
      this.props.updateBooking(
        this.state.booking.id,
        booking
      )
    }
  }

  updateBookingState = (event) => {
    this.setState({
      booking: {
        ...this.state.booking,
        [event.target.name]: event.target.value
      }
    })
  }

  render() {
    const booking = this.state.booking
    console.log(booking)
    return (
      <div className="table-container">
        <table className="list-container">
          <thead>
            <tr>
              <th className={this.props.sortParams.key === 'project_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("project_name")}>Location</th>
              <th className={this.props.sortParams.key === 'roomtype_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("roomtype_name")}>Category</th>
              <th className={this.props.sortParams.key === 'apartment_number' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("apartment_number")}>Apartment</th>
              <th className={this.props.sortParams.key === 'room_number' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("room_number")}>Number</th>
              <th className={this.props.sortParams.key === 'user_name' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("user_name")}>Tenant</th>
              <th className={this.props.sortParams.key === 'move_in' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("move_in")}>Move In</th>
              <th className={this.props.sortParams.key === 'move_out' ? 'sorted' : ''} onClick={() => this.handleHeaderClick("move_out")}>Move Out</th>
            </tr>
          </thead>
          <tbody>
            {
              this.props.bookings && this.props.bookings.map((booking) => {
                return <ListItem key={booking.id} onClick={() => this.openModal(booking)} {...booking} />;
              })
            }
          </tbody>
        </table>
        <Modal
            visible={this.state.visible}
            width="90%"
            effect="fadeInUp"
            onClickAway={() => this.closeModal()}>
            {
              booking ?
                <div className="modal-container">
                  <button className="closeModalButton" onClick={() => this.closeModal()}>Close</button>
                  <div className="modal-header">
                    <h1 id="modal-title">{booking.user_name}</h1>
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
                          <td>Move In:</td>
                          <td>
                            {
                              this.state.edit ?
                                <input onChange={this.updateBookingState} className="form-control" type="date" defaultValue={booking.move_in} id="move_in" name="move_in" min={new Date}/>
                              :
                                moment(booking.move_in).format('Do MMMM YYYY')
                            }
                          </td>
                        </tr>
                        <tr>
                          <td>Move Out:</td>
                          <td>
                            {
                              this.state.edit ?
                                <input onChange={this.updateBookingState} className="form-control" type="date" defaultValue={booking.move_out} id="move_out" name="move_out" min={new Date}/>
                              :
                              moment(booking.move_out).format('Do MMMM YYYY')
                            }
                          </td>
                        </tr>
                        <tr>
                          <td>Location:</td>
                          <td>
                            {
                              booking.project_name
                            }
                          </td>
                        </tr>
                        <tr>
                          <td>Roomtype:</td>
                          <td>{booking.roomtype_name}</td>
                        </tr>
                        <tr>
                          <td>Room:</td>
                          <td>{booking.room_number}</td>
                        </tr>
                        <tr>
                          <td>Phone:</td>
                          <td style={{display: 'flex', alignItems: 'center'}}>
                            {
                              this.state.edit ?
                                [
                                  booking.phone_code,
                                  <input key="phoneNumberInput" onChange={this.updateBookingState} className="form-control" type="text" value={booking.phone_number} id="phone_number" name="phone_number" />
                                ]
                              :
                                `${booking.phone_code} ${booking.phone_number}`
                            }
                          </td>
                        </tr>
                        <tr>
                          <td>Booking Id:</td>
                          <td>{booking.id}</td>
                        </tr>
                      </tbody>
                    </table>
                    <div className="button-container">
                      <select className="form-control form-search" defaultValue={this.state.booking.state} name="state" onChange={this.handleChange}>
                        <option value="booked">booked</option>
                        <option value="deposit outstanding">deposit outstanding</option>
                        <option value="bookingFee payment failed">bookingFee payment failed</option>
                        <option value="cancel">cancel</option>
                      </select>
                      <a href={`/bookings/${this.state.booking.booking_auth_token}/${this.state.booking.id}/projects`} className="bookingProcess">Go to Booking Process</a>
                    </div>
                  </div>
                </div>
              :
                <h1>Nothing Slected</h1>
            }
        </Modal>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
    bookings: state.app.bookings,
    sortParams: state.app.sortParams
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ setSortParams, applyFilter, updateBooking }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(RoomList);
