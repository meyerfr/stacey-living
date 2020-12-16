import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { reduxForm, Field } from 'redux-form'
import moment from 'moment'

import {Elements} from '@stripe/react-stripe-js';
import {loadStripe} from '@stripe/stripe-js';

import CheckoutForm from './checkout_form';
import { fetchBooking, updateBooking, updateUser } from '../actions';

const stripePromise = loadStripe("pk_test_FSjxxtkIfO0UtESzFKdjLarS");
// Make sure to call `loadStripe` outside of a component’s render to avoid
// recreating the `Stripe` object on every render.

class Payment extends Component {
	constructor(props) {
		super(props)
		this.state = {
			gender: 'male'
		}
	}

	componentDidMount() {
		this.props.fetchBooking(this.props.match.params.booking_id);
	}

	componentDidUpdate(prevProps) {
		if (prevProps.booking != this.props.booking) {
			this.setState({
				gender: this.props.booking.user.gender.toLowerCase()
			})
		}
	}

	changeGender = () => {
		this.setState({
			gender: this.state.gender === 'male' ? 'female' : 'male'
 		})
	}

	renderSecurePayment() {
		return(
			<div className="secure-payment">
        <i className="fas fa-lock"></i>
        <span>Secure Payment</span>
        <div className="cards">
	        <i className="fab fa-cc-amex"></i>
	        <i className="fab fa-cc-visa"></i>
	        <i className="fab fa-cc-mastercard"></i>
        </div>
      </div>
		)
	}

	renderRadioField = (gender) => {
		const currentGender = this.state.gender
		return(
			<div className="gender-input">
				<input type="radio" id={gender} key="genderInput" name="gender" value={gender} checked={this.state.gender === gender} onChange={this.changeGender}/>
	  		<label className="label" htmlFor={gender} key="genderLabel">{gender}</label>
			</div>
		)
	}

	updateUserOnSubmit = () => {
		let user = this.props.booking.user
		user.gender = this.state.gender
		this.props.updateUser(user)
	}

	updateBookingOnSubmit = (new_state) => {
		let booking = {
			state: new_state
		}

		updateBooking(
			this.props.match.params.booking_id,
			booking,
			() => {
				this.props.history.push(`/bookings/${this.props.match.params.booking_auth_token}/${this.props.match.params.booking_id}/success`);
    	}
  	)
	}

	render() {
		const user = (this.props.booking && this.props.booking.user) && this.props.booking.user
		const booking = this.props.booking
		return(
			<div className="payment-wrapper2">
				<div className="payment-container2">
					<div className="payment-header">
						<h2>Booking Summary</h2>
						{this.renderSecurePayment()}
					</div>
					<div className="payment-body">
						<div className="left-szene-container">
							<h3 className="szene-header header-margin">Personal Information</h3>
							{user &&
								<div className="user-info-list">
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
									</div>

									<div className="user-info-item">
										<span className="label">Date of Birth</span>
										<span className="value">{moment(user.dob).format('DD/MM/YYYY')}</span>
									</div>
								</div>
							}

							<div className="stripe-section">
								<div className="section-header header-margin">
									<h3>Payment Details</h3>
									{this.renderSecurePayment()}
								</div>
								<Elements stripe={stripePromise}>
						      <CheckoutForm booking_id={this.props.match.params.booking_id} updateUserOnSubmit={this.updateUserOnSubmit} updateBookingOnSubmit={this.updateBookingOnSubmit} booking_auth_token={this.props.match.params.booking_auth_token} history={this.props.history} />
						    </Elements>
							</div>
						</div>

						<div className="right-szene-container">
							<h3 className="szene-header header-margin">Booking Summary</h3>
							<div className="booking-summary-list">
								<div className="booking-section">
									<div className="booking-summary-list-item">
										<span className="light">Room Category</span>
										<span>{booking && booking.roomtype}</span>
									</div>
									<div className="booking-summary-list-item">
										<span className="light">Move-in</span>
										<span>{booking && moment(booking.move_in).format('DD/MM/YYYY')}</span>
									</div>
									<div className="booking-summary-list-item">
										<span className="light">Move-out</span>
										<span>{booking && moment(booking.move_out).format('DD/MM/YYYY')}</span>
									</div>
									<div className="booking-summary-list-item">
										<span className="light">Duration of your stay</span>
										<span>{booking && booking.duration} days</span>
									</div>
								</div>
								<div className="booking-section">
									<span className="booking-section-header">Monthly Cost</span>
									<div className="booking-summary-list-item">
										<span className="light">All-inclusive Monthly Rent</span>
										<span>{booking && booking.price} €</span>
									</div>
								</div>
								<div className="booking-section important">
									<span className="booking-section-header">Total Now</span>
									<div className="booking-summary-list-item">
										<span>Booking Fee</span>
										<span>80 €</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		)
	}
}

function mapStateToProps(state) {
  return {
    booking: state.booking
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ fetchBooking, updateUser }, dispatch);
}

export default reduxForm({ form: 'newPostForm' })(
	connect(mapStateToProps, mapDispatchToProps)(Payment)
);
