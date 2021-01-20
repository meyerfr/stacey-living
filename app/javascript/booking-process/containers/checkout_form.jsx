import React from 'react';
import {ElementsConsumer, CardElement} from '@stripe/react-stripe-js';

import CardSection from './card_section';

import Spinner from 'react-bootstrap/Spinner';


class CheckoutForm extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      client_secret: '',
      loading: false,
      terms_and_conditions: false,
      showTermsAndConditionsError: false
    }
  }

  componentDidMount() {
    (async () => {
      const response = await fetch(`/api/v1/bookings/${this.props.booking_auth_token}/${this.props.booking_id}/secret`);
      const client_secret = await response.json();
      this.setState({
        client_secret: client_secret.client_secret
      })
      // Call stripe.confirmCardPayment() with the client secret.
    })();
  }

  changeLoading = () => {
    this.setState({
      loading: !this.state.loading
    })
  }

  handleSubmit = async (event) => {
    // We don't want to let default form submission happen here,
    // which would refresh the page.
    event.preventDefault();
    this.changeLoading()
    const {stripe, elements} = this.props


    if (!stripe || !elements) {
      // Stripe.js has not yet loaded.
      // Make  sure to disable form submission until Stripe.js has loaded.
      this.changeLoading()
      return;
    }

    if (!this.state.terms_and_conditions) {
      this.setState({
        showTermsAndConditionsError: true,
        loading: false
      })
      return;
    }
    let result = null
    await stripe.confirmCardPayment(this.state.client_secret, {
      payment_method: {
        card: elements.getElement(CardElement),
        billing_details: {
          name: 'Jenny Rosen',
        },
      }
    })
    .then((r) => result = r)
    .then(() => this.changeLoading());

    if (result.error) {
      // Show error to your customer (e.g., insufficient funds)
      // console.log(result.error);
      this.props.updateBookingOnSubmit('bookingFee payment failed')
    } else {
      // The payment has been processed!
      if (result.paymentIntent.status === 'succeeded') {
        // console.log('handle Success')
        this.props.updateUserOnSubmit()
        this.props.updateBookingOnSubmit('deposit outstanding')
        // Show a success message to your customer
        // There's a risk of the customer closing the window before callback
        // execution. Set up a webhook or plugin to listen for the
        // payment_intent.succeeded event that handles any business critical
        // post-payment actions.
      }
    }
  };

  changeTermsAndConditions = () => {
    !this.state.terms_and_conditions && this.state.showTermsAndConditionsError ?
      this.setState({
        terms_and_conditions: !this.state.terms_and_conditions,
        showTermsAndConditionsError: false
      })
    :
      this.setState({terms_and_conditions: !this.state.terms_and_conditions})
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <CardSection />
        <div className={this.state.showTermsAndConditionsError ? "terms-and-conditions error" : "terms-and-conditions"}>
          <input type="checkbox" id="terms-and-conditions-checkbox" key="termsAndConditionsInput" name="gender" value="terms-and-conditions" checked={this.state.terms_and_conditions} onChange={this.changeTermsAndConditions}/>
          <label className="label" htmlFor="terms-and-conditions-checkbox" key="termsAndConditionsLabel">I have read and agree to the <a href='#' target="_blank">Terms & Conditions</a></label>
        </div>
        <span className="info">By completing the reservation you agree to our <a href='https://www.stacey.de/data-protection' target="_blank">privacy policy</a></span>
        <button className="stacey-button reverse-hover" disabled={!this.props.stripe}>{this.state.loading ? <Spinner animation="border" role="status" /> : 'Pay 80€'}</button>
      </form>
    );
  }
}

const InjectedCheckoutForm = (props) => {
  return (
    <ElementsConsumer>
      {({stripe, elements}) => (
        <CheckoutForm  stripe={stripe} elements={elements} booking_id={props.booking_id} updateUserOnSubmit={props.updateUserOnSubmit} updateBookingOnSubmit={props.updateBookingOnSubmit} booking_auth_token={props.booking_auth_token} history={props.history} />
      )}
    </ElementsConsumer>
  );
}


export default InjectedCheckoutForm;
