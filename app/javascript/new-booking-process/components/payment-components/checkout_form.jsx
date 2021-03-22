import React, { Component } from 'react'
import {ElementsConsumer, CardElement} from '@stripe/react-stripe-js';

class CheckoutForm extends Component {
  render() {
    return(
      <form onSubmit={this.props.handleSubmit}>
        <CardSection />
        <div className={this.state.showTermsAndConditionsError ? "terms-and-conditions error" : "terms-and-conditions"}>
          <input type="checkbox" id="terms-and-conditions-checkbox" key="termsAndConditionsInput" name="gender" value="terms-and-conditions" checked={this.state.terms_and_conditions} onChange={this.changeTermsAndConditions}/>
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
        <CheckoutForm stripe={stripe} elements={elements} />
      )}
    </ElementsConsumer>
  );
}


export default InjectedCheckoutForm;
