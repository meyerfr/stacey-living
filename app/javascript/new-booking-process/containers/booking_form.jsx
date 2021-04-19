import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Link, useHistory as history } from 'react-router-dom';
import Flatpickr from "react-flatpickr";
import moment from 'moment'

import { chooseRoom } from '../actions'


class BookingForm extends Component {
  constructor(props) {
    // let defaultMinMoveInDate = moment(props.roomtype.availabilities[0].next_available_move_in_date).format()
    let firstAvailability = props.roomtype.availabilities[0]
    let minMoveInDate = moment(firstAvailability.next_available_move_in_date).format()
    let minMoveOutDate = moment(minMoveInDate).add(3,'M').format()
    minMoveOutDate = moment(`14.${moment(minMoveOutDate).format('MM')}.${moment(minMoveOutDate).format('YYYY')}`, "DD.MM.YYYY").format()
    super(props)
    this.state = {
      // selectedRoom: props.roomtype.availabilities[0].room_id,
      // selectedMoveInDate: defaultMinMoveInDate,
      // moveOut: defaultMinMoveOutDate,
      price: props.roomtype.prices[0],
      booking: {
        moveIn: minMoveInDate,
        moveOut: minMoveOutDate,
        roomId: firstAvailability.room_id
      },
      options: {
        altInput: true,
        altFormat: "d.m.Y",
        dateFormat: "Y-m-d",
        static: true,
        enable: [
          function(date) {
            // return true to enable
            return (date.getDate() === 14 || date.getDate() === (new Date(date.getFullYear(), date.getMonth()+1, 0)).getDate());
          }
        ],
        locale: {
          firstDayOfWeek: 1 // start week on Monday
        },
        minDate: minMoveOutDate,
        maxDate: moment(minMoveOutDate).add(2,'Y').format()
      }
    }
  }

  diff(d1, d2) {
    let diff = moment(d2).subtract(1, 'd').diff(moment(d1), 'months')
    return diff
  }

  handleMoveInChange = () => {
    const moveInDate = moment(event.target.selectedOptions[0].label, 'DD.MM.YYYY').format();
    let earliestMoveOutDate = moment(moveInDate).add(3, 'M').format();
    const earliestMoveOutDateDay = moment(earliestMoveOutDate).format('D')
    switch (true) {
      case (earliestMoveOutDateDay < 14):
        earliestMoveOutDate = moment(`14.${moment(earliestMoveOutDate).format('M')}.${moment(earliestMoveOutDate).format('YYYY')}`, "DD.MM.YYYY").format()
        break;
      case (earliestMoveOutDateDay > 14):
        earliestMoveOutDate = moment(earliestMoveOutDate).endOf('month').format()
        break;
      default:
        earliestMoveOutDate
    }

    const maxMoveOutDate = moment(earliestMoveOutDate).add(2, 'Y').format();

    let newMoveOutDate = this.state.moveOut
    if (this.state.moveOut < earliestMoveOutDate) {
      newMoveOutDate = earliestMoveOutDate
    }

    this.setState({
      booking: {
        moveOut: newMoveOutDate,
        moveIn: moveInDate,
        roomId: event.target.value
      },
      options: {
        minDate: earliestMoveOutDate,
        maxDate: maxMoveOutDate
      },
      price: this.findPrice(moveInDate, newMoveOutDate)
    })
  }

  handleMoveOutChange = (move_out) => {
    const moveOut = move_out[0]
    this.setState({
      booking: {
        ...this.state.booking,
        moveOut: moment(moveOut).format()
      },
      price: this.findPrice(this.state.booking.moveIn, moment(moveOut).format())
    })
  }

  findPrice = (moveIn, moveOut) => {
    let prices = this.props.roomtype.prices
    let date_diff = this.diff(moveIn, moveOut)
    let price = prices[2]
    switch(true) {
      case (date_diff < 5):
        price = prices[0]
        break;
      case (date_diff < 8):
        price = prices[1]
        break;
      default:
        price
    }
    return price;
  }

  chooseRoom = () => {
    let booking = this.state.booking
    booking = {
      move_in: booking.moveIn,
      move_out: booking.moveOut,
      room_id: booking.roomId,
      price: this.state.price
    }

    this.props.chooseRoom(this.props.params.booking_id, booking, () => {
      this.props.history.push(`/bookings/${this.props.params.booking_auth_token}/${this.props.params.booking_id}/projects/${this.props.params.project_id}/roomtypes/${this.props.params.roomtype_id}/contract`)
    })
  }

  render() {
    console.log('price', this.state.price)
    const roomtype = this.props.roomtype
    const move_out = this.state.booking.moveOut
    return (
      <div className="booking-form">
        <div className="booking-section">
          <span className="label">When do you want to move in?</span>
          <select className="booking-form-input" defaultValue='current' name="move_in" onChange={() => this.handleMoveInChange()}>
            {
              roomtype.availabilities.map((availability) => {
                return <option key={availability.room_id} value={availability.room_id}>{moment(availability.next_available_move_in_date).format('DD.MM.YYYY')}</option>
              })
            }
          </select>
        </div>
        <div className="booking-section">
          <span className="label">Move Out</span>
          <Flatpickr
            options={this.state.options}
            value={move_out}
            className='booking-form-input'
            id='moveOutFlatpickr'
            onChange={move_out => this.handleMoveOutChange(move_out)}
          />
        </div>
        <div className="booking-section bordered margin-top">
          <span>Rent per Month</span>
          <table>
            <tbody>
              <tr>
                {
                  roomtype.prices.map((price) => {
                    return (
                      <td key={`duration${price.id}`} className={price.id == this.state.price.id ? 'active' : ''}>{price.duration}</td>
                    )
                  })
                }
              </tr>
              <tr>
                {
                  roomtype.prices.map((price) => {
                    return (
                      <td key={`amount${price.id}`} className={price.id == this.state.price.id ? 'active' : ''}>€{price.amount}</td>
                    )
                  })
                }
              </tr>
            </tbody>
          </table>
        </div>
        <div className="booking-section bordered margin-bottom">
          <span>Refundable Deposit</span>
          <span>2 Month Rent</span>
        </div>
        <button className="stacey-button reverse-hover" onClick={this.chooseRoom}>Explore</button>
      </div>
    )
  }
}


// function mapStateToProps(state) {
//   const projectId = parseInt(ownProps.match.params.project_id);
//   return {
//     projects: state.projects,
//     project: state.projects.find((project) => project.id === projectId),
//     roomtypes: state.roomtypes
//   };
// }

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ chooseRoom }, dispatch);
}

export default connect(null, mapDispatchToProps)(BookingForm);

