const updatePricing = (event) => {
  var newDuration = document.querySelector('.user-update-input-field').querySelector('select').value;
  var price = document.querySelector('.price-per-month');
  var prices = document.getElementById('prices').children;
  var deposit = document.querySelector('.deposit-text');

  // newDuration = The new duration of Stay
  if (parseInt(newDuration, 10) < 5) {
    price.innerHTML = `€ ${prices[0].innerHTML}`
    deposit.innerHTML = `€ ${prices[0].innerHTML}`
  } else if (parseInt(newDuration, 10) < 8) {
    price.innerHTML = `€ ${prices[1].innerHTML}`
    deposit.innerHTML = `€ ${parseInt(prices[0].innerHTML) * 2}`
  } else {
    price.innerHTML = `€ ${prices[2].innerHTML}`
    deposit.innerHTML = `€ ${parseInt(prices[0].innerHTML) * 3}`
  };
}

function addEventListenerToDuration() {
  const userUpdateInputField = document.querySelector('.user-update-input-field');
  if (userUpdateInputField) {
    const durationOptions = userUpdateInputField.querySelector('select');
    durationOptions.addEventListener('change', updatePricing);
  };
};

export { addEventListenerToDuration };
