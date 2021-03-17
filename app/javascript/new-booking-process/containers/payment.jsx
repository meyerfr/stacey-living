import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { Elements } from "@stripe/react-stripe-js";
import { loadStripe } from "@stripe/stripe-js";

import BookingSummary from "../components/payment-components/booking_summary";
import CheckoutForm from "./checkout_form";
import UserSummary from "../components/payment-components/user_summary";

const stripePromise = loadStripe("pk_test_FSjxxtkIfO0UtESzFKdjLarS");

import ProgressNavbar from '../components/progress_navbar'

import { completeBooking, updateUser } from '../actions';

class Payment extends Component {
  constructor(props) {
    super(props)
    this.state = {}
  }

  componentDidMount() {
    this.setState({
      user: this.props.booking.user
    })
  }

  updateGender = (gender) => {
    this.setState({
      user: {
        ...this.state.user,
        'gender': gender
      }
    })
  }

  completeBooking = () => {
    this.props.updateUser(this.state.user, () => {
      this.props.completeBooking(this.props.booking.id)
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

  render() {
    return[
      <ProgressNavbar step={5} history={this.props.history} params={this.props.match.params} key="ProgressNavbar4" />,
      <div className="payment-wrapper2" key="paymentWrapper2">
        <div className="payment-container2">
          <div className="payment-header">
            <h2>Booking Summary</h2>
            {this.renderSecurePayment()}
          </div>
          <div className="payment-body">
            <div className="left-szene-container">
              <UserSummary user={this.state.user ? this.state.user : this.props.booking.user} updateGender={this.updateGender} />
              <div className="stripe-section">
                <div className="section-header header-margin">
                  <h3>Payment Details</h3>
                  {this.renderSecurePayment()}
                </div>
                <Elements stripe={stripePromise} >
                  <CheckoutForm booking_id={this.props.match.params.booking_id} booking={this.props.booking} completeBooking={this.completeBooking} />
                </Elements>
              </div>
              {
                // <CheckoutForm booking={this.props.booking} />
              }


            </div>

            <div className="right-szene-container">
              <BookingSummary booking={this.props.booking} />
            </div>
          </div>
        </div>
      </div>
    ]
  }
}

function mapStateToProps(state) {
  return {
    booking: state.booking
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ completeBooking, updateUser }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Payment);
