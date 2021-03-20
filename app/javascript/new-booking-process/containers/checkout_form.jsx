import React, { Component } from 'react'
import {ElementsConsumer, CardElement} from '@stripe/react-stripe-js';

import CardSection from '../components/payment-components/card_section'

import { createPaymentIntent, updateUser, updateBooking } from '../actions'

class CheckoutForm extends Component {
  constructor(props) {
    super(props)
    this.state = {
      termsAndConditionsChecked: false,
      termsAndConditionsError: false
    }
  }

  componentDidMount() {
    createPaymentIntent(this.props.booking_id, (r) => {
      this.setState({
        client_secret: r.client_secret
      })
    })
  }

  changeTermsAndConditions = () => {
    const newTermsAndConditionsChecked = !this.state.termsAndConditionsChecked
    this.setState({
      termsAndConditionsChecked: newTermsAndConditionsChecked,
      termsAndConditionsError: newTermsAndConditionsChecked ? false : this.state.termsAndConditionsError
    })
  }

  handleSubmit = async event => {
    event.preventDefault();

    const { stripe, elements } = this.props;
    if (!stripe || !elements) {
      return;
    }

    const user = this.props.booking.user
    const card = elements.getElement(CardElement);
    const result = await stripe.confirmCardPayment(this.state.client_secret, {
      payment_method: {
        card: card,
        billing_details: {
          name: `${user.first_name} ${user.last_name}`,
          email: user.email,
          address: {
            "city": user.address.city,
            "postal_code": user.address.zip
          }
        }
      }
    });

    if (!this.state.termsAndConditionsChecked) {
      this.setState({
        termsAndConditionsError: true
      })
      return;
    }
    if (result.error) {
      console.log(result.error.message);
    } else {
      if (result.paymentIntent.status === 'succeeded') {
        // console.log('success', result);
        this.props.completeBooking(result)
      } else{
        console.log('no success', result);
      }
    }
  };

  render() {
    return(
      <form onSubmit={this.handleSubmit}>
        <CardSection />
        <div className={this.state.termsAndConditionsError ? "terms-and-conditions error" : "terms-and-conditions"}>
          <input type="checkbox" id="terms-and-conditions-checkbox" key="termsAndConditionsInput" name="gender" value="terms-and-conditions" checked={this.state.termsAndConditionsChecked} onChange={this.changeTermsAndConditions}/>
          <label className="label" htmlFor="terms-and-conditions-checkbox" key="termsAndConditionsLabel">I have read and agree to the <a href='#' target="_blank">Terms & Conditions</a></label>
        </div>
        <span className="info">By completing the reservation you agree to our <a href='https://www.stacey.de/data-protection' target="_blank">privacy policy</a></span>
        <button className="stacey-button reverse-hover" disabled={!this.props.stripe}>{this.state.loading ? <Spinner animation="border" role="status" /> : 'Pay 80€'}</button>
      </form>
    )
  }
}


const InjectedCheckoutForm = (props) => {
  return (
    <ElementsConsumer>
      {({ stripe, elements }) => (
        <CheckoutForm stripe={stripe} elements={elements} booking_id={props.booking_id} booking={props.booking} completeBooking={props.completeBooking} />
      )}
    </ElementsConsumer>
  );
}


export default InjectedCheckoutForm;
