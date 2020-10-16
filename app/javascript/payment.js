function payment() {
  if (document.getElementById('card-element')) {
    // const stripe = Stripe('pk_test_FSjxxtkIfO0UtESzFKdjLarS');
    const stripe = Stripe('pk_live_iSuTPX4CbDfy9CHEz2GChCMT');
    const elements = stripe.elements();

    const style = {
      base: {
        color: '#32325d',
        fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
        fontSize: '16px',
        fontSmoothing: 'antialiased',
        "::placeholder": {
          color: '#CFD7DF'
        },
        ':-webkit-autofill': {
          color: '#32325d',
        },
      },
      invalid: {
        color: '#fa755a',
        iconColor: '#fa755a',
        ':-webkit-autofill': {
          color: '#fa755a',
        },
      }
    };



    const card = elements.create('card', { style });

    card.mount('#card-element');

    // card.addEventListener('change', ( {error} ) => {
    //   const displayError = document.getElementById('card-error');
    //   if (error) {
    //     displayError.textContent = error.message;
    //   } else {
    //     displayError.textContent = '';
    //   }
    // });

    card.addEventListener('change', function(event) {
      var displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });

    const clientSecret = document.getElementById('client_secret').innerText

    const customerFirstName = document.getElementById('booking_user_attributes_first_name').value
    const customerLastName = document.getElementById('booking_user_attributes_last_name').value


    const form = document.getElementById('payment-form');


    form.addEventListener('submit', async(event) => {
      event.preventDefault();
      // if (document.getElementById('terms-and-conditions').checked) { //check if customer agreed to terms and conditions
      stripe.confirmCardPayment(clientSecret, {
        payment_method: {
          card: card,
          billing_details: {
            name: customerFirstName + ' ' + customerLastName
          }
        }
      }).then(function(result) {

        if (result.error) {
          // Show error to your customer
          console.log(result.error.message);
        } else if(!document.getElementById('terms-and-conditions').checked){
          var errorElement = document.createElement('SPAN');
          var errorTextNode = document.createTextNode("Please agree to the Terms and Conditions before proceeding");
          errorElement.appendChild(errorTextNode);
          errorElement.setAttribute('class', 'terms-and-conditions-error')
          const termsAndConditionsDiv = document.querySelector('.terms-and-conditions');
          termsAndConditionsDiv.appendChild(errorElement);
          var errorElementsHeight = errorElement.offsetHeight
          termsAndConditionsDiv.setAttribute("style", `bottom: -${errorElementsHeight};`);
          termsAndConditionsDiv.setAttribute("style", `margin-bottom: ${errorElementsHeight + 5};`);
        } else {
          if (result.paymentIntent.status === 'succeeded') {
            form.submit();
            // Show a success message to your customer
            // There's a risk of the customer closing the window before callback execution
            // Set up a webhook or plugin to listen for the payment_intent.succeeded event
            // to save the card to a Customer

            // The PaymentMethod ID can be found on result.paymentIntent.payment_method
          }
        }
      });
    });
  }
}

export { payment }


// const form = document.getElementById('payment-form');

// form.addEventListener('submit', async(event) => {
//   event.preventDefault();

//   const { token, error } = await stripe.createToken(card);

//   if (error) {
//     const errorElement = document.getElementById('card-error');
//     errorElement.textContent = error.message;
//   } else {
//     stripeTokenHandler(token);
//   }
// });


// const stripeTokenHandler = (token) => {
//   const form = document.getElementById('payment-form');
//   const hiddenInput = document.createElement('input');
//   hiddenInput.setAttribute('type', 'hidden');
//   hiddenInput.setAttribute('name', 'stripeToken');
//   hiddenInput.setAttribute('value', token.id);
//   form.appendChild(hiddenInput);

//   ['type', 'last4', 'exp_month', 'exp_year', 'cardnumber'].forEach(function(field) {
//     addCardField(form, token, field);
//   });

//   form.submit();
// }

// function addCardField(form, token, field) {
//   let hiddenInput = document.createElement('input');
//   hiddenInput.setAttribute('type', 'hidden');
//   hiddenInput.setAttribute('name', 'user[card_' + field + ']');
//   hiddenInput.setAttribute('value', token.card[field]);
//   form.appendChild(hiddenInput);
// }
