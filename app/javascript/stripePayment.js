const stripe_section = document.querySelector('.stripe-section');

function proceedPayment() {
  // Create a Stripe client.
  // Note: this merchant has been set up for demo purposes.
  var stripe = Stripe('pk_test_FSjxxtkIfO0UtESzFKdjLarS');
  // Create an instance of Elements.
  var elements = stripe.elements();

  // Custom styling can be passed to options when creating an Element.
  // (Note that this demo uses a wider set of styles than the guide below.)
  var style = {
    base: {
      color: '#32325d',
      fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif',
      fontSmoothing: 'antialiased',
      fontSize: '16px',
      '::placeholder': {
        color: '#aab7c4'
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

  // Create an instance of the iban Element.
  var iban = elements.create('iban', {
    // style: style,
    supportedCountries: ['SEPA'],
  });

  // Add an instance of the iban Element into the `iban-element` <div>.
  // console.log('insert iban element')
  iban.mount('#iban-element');

  var errorMessage = document.getElementById('error-message');
  var bankName = document.getElementById('bank-name');

  iban.on('change', function(event) {
    // Handle real-time validation errors from the iban Element.
    if (event.error) {
      errorMessage.textContent = event.error.message;
      errorMessage.classList.add('visible');
    } else {
      errorMessage.classList.remove('visible');
    }

    // Display bank name corresponding to IBAN, if available.
    if (event.bankName) {
      bankName.textContent = event.bankName;
      bankName.classList.add('visible');
    } else {
      bankName.classList.remove('visible');
    }
  });

  // Handle form submission.
  var form = document.getElementById('stripe-form');
  function stripeSourceHandler(source) {
    // Insert the Source ID into the form so it gets submitted to the server.
    var form = document.getElementById('stripe-form');
    var hiddenInput = document.createElement('input');
    hiddenInput.setAttribute('type', 'hidden');
    hiddenInput.setAttribute('name', 'stripeSource');
    hiddenInput.setAttribute('value', source.id);
    form.appendChild(hiddenInput);

    // Submit the form.
    form.submit();
  }

  form.addEventListener('submit', function(event) {
    event.preventDefault();
    // showLoading();

    var sourceData = {
      type: 'sepa_debit',
      currency: 'eur',
      owner: {
        name: document.querySelector('input[name="user[first_name]"]').value + " " + document.querySelector('input[name="user[last_name]"]').value,
        email: document.querySelector('input[name="user[email]"]').value,
      },
      mandate: {
        // Automatically send a mandate notification email to your customer
        // once the source is charged.
        notification_method: 'email',
      }
    };

    // Call `stripe.createSource` with the iban Element and additional options.
    stripe.createSource(iban, sourceData).then(function(result) {
      if (result.error) {
        // Inform the customer that there was an error.
        errorMessage.textContent = result.error.message;
        errorMessage.classList.add('visible');
        // stopLoading();
      } else {
        // Send the Source to your server to create a charge.
        errorMessage.classList.remove('visible');
        stripeSourceHandler(result.source);
      }
    });
  });
}

function stripeProcess() {
  if (stripe_section) {
    proceedPayment();
  }
}

export { stripeProcess };
