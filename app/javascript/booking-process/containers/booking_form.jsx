import React, { Component } from 'react';
import { Link, useHistory as history } from 'react-router-dom';
import { updateBooking } from '../actions'
import Flatpickr from "react-flatpickr";
import moment from 'moment'

export default class BookingForm extends Component {
	constructor(props) {
		let defaultMinMoveInDate = moment(props.roomtype.availabilities[0].next_available_move_in_date).format()
		let minMoveOutDate = moment(defaultMinMoveInDate).add(3,'M').format()
		let defaultMinMoveOutDate = moment(`14.${moment(minMoveOutDate).format('MM')}.${moment(minMoveOutDate).format('YYYY')}`, "DD.MM.YYYY").format()
		super(props)
		this.state = {
			selectedRoom: props.roomtype.availabilities[0].room_id,
			selectedMoveInDate: defaultMinMoveInDate,
			moveOut: defaultMinMoveOutDate,
			price: props.roomtype.prices[0],
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
		    minDate: defaultMinMoveOutDate,
		    maxDate: moment(defaultMinMoveOutDate).add(2,'Y').format()
			}
		}
	}

	diff(d1, d2) {
		let diff = moment(d2).subtract(1, 'd').diff(moment(d1), 'months')
		// console.log(diff)
		return diff
	}

	handleMoveInChange = () => {
		let moveInDate = moment(event.target.selectedOptions[0].label, 'DD.MM.YYYY').format();
		let earliestMoveOutDate = moment(moveInDate).add(3, 'M').format();
		let earliestMoveOutDateDay = moment(earliestMoveOutDate).format('D')
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

		let maxMoveOutDate = moment(earliestMoveOutDate).add(2, 'Y').format();

		let newMoveOutDate = this.state.moveOut
		if (this.state.moveOut < earliestMoveOutDate) {
			newMoveOutDate = earliestMoveOutDate
		}

		this.setState({
			selectedRoom: event.target.value,
			selectedMoveInDate: moveInDate,
			options: {
				minDate: earliestMoveOutDate,
				maxDate: maxMoveOutDate
			},
			moveOut: newMoveOutDate
		}, this.setPrice)
	}

	handleMoveOutChange = (move_out) => {
		this.setState({
			moveOut: moment(move_out[0]).format()
		}, this.setPrice)
	}


	setPrice = () => {
		let prices = this.props.roomtype.prices
		let date_diff = this.diff(this.state.selectedMoveInDate, this.state.moveOut)
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
		this.setState({
			price: price
		})
	}

	handleSubmit = () => {
		let booking = {
			room_id: this.state.selectedRoom,
			move_in: this.state.selectedMoveInDate,
			move_out: this.state.moveOut
		}
		updateBooking(
			this.props.booking_id,
			booking,
			() => {
    		this.props.history.push(`/bookings/${this.props.booking_auth_token}/${this.props.booking_id}/contract`);
    	}
  	)
	}

	render() {
		const roomtype = this.props.roomtype
		const move_out = this.state.moveOut
		// console.log(this.state)
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
	      	<span>€{this.state.price}</span>
	      </div>
	      <div className="booking-section bordered margin-bottom">
	      	<span>Refundable Deposit</span>
	      	<span>2 Month Rent</span>
	      </div>
	     	<button className="stacey-button reverse-hover" onClick={() => this.handleSubmit()}>Explore</button>
			</div>
		)
	}
}