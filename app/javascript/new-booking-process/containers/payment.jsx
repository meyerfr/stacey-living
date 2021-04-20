import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';

import { Elements } from "@stripe/react-stripe-js";
import { loadStripe } from "@stripe/stripe-js";

import BookingSummary from "../components/payment-components/booking_summary";
import CheckoutForm from "./checkout_form";
import UserSummary from "../components/payment-components/user_summary";
import SuccessModal from "../components/success_modal";

const stripePromise = loadStripe("pk_test_FSjxxtkIfO0UtESzFKdjLarS");

import ProgressNavbar from '../components/progress_navbar'

import { completeBooking, updateUser, fetchProjects } from '../actions';

class Payment extends Component {
  constructor(props) {
    super(props)
    this.state = {
      showSuccess: false
    }
  }

  componentDidMount() {
    if (!this.props.project) {
      this.props.fetchProjects()
    }
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

  completeBooking = (result) => {
    console.log('completeBooking', result)
    this.props.updateUser(this.state.user, () => {
      this.props.completeBooking(this.props.booking.id, () => {
        this.setState({showSuccess: true})
      })
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
    console.log(this.props.booking)
    return[
      <ProgressNavbar step={5} history={this.props.history} params={this.props.match.params} key="ProgressNavbar4" />,
      <div className="payment-wrapper2" key="paymentWrapper2">
        <div className="payment-container2">
          <div className="payment-header">
            <h2>Booking Summary</h2>
            {this.renderSecurePayment()}
          </div>
          <div className="first-item">
            <UserSummary user={this.state.user ? this.state.user : this.props.booking.user} updateGender={this.updateGender} />
          </div>
          <div className="seocond-item slide-up">
            <BookingSummary booking={this.props.booking} />
          </div>
          <div className="stripe-section item">
            <div className="section-header header-margin">
              <h3>Payment Details</h3>
              {this.renderSecurePayment()}
            </div>
            <Elements stripe={stripePromise} >
              <CheckoutForm booking_id={this.props.match.params.booking_id} booking={this.props.booking} completeBooking={this.completeBooking} />
            </Elements>
          </div>
        </div>
      </div>,
      <SuccessModal show={this.state.showSuccess} project_name={this.props.project?.name} price={this.props.booking.price} key='SuccessModal' />
    ]
  }
}

function mapStateToProps(state, ownProps) {
  const projectId = parseInt(ownProps.match.params.project_id);
  return {
    booking: state.booking,
    project: state.projects.find((project) => project.id === projectId),
  };
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ completeBooking, updateUser, fetchProjects }, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Payment);
