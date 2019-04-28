const updatePricing = (event) => {
  var newDuration = document.querySelector('.user-update-input-field').querySelector('select').value;
  var price = document.querySelector('.price-per-month');
  var prices = document.getElementById('prices').children;
  var deposit = document.querySelector('.deposit-text');
  var info_fields = document.querySelectorAll('.info-field');

  // newDuration = The new duration of Stay
  if (parseInt(newDuration, 10) < 5) {
    price.innerHTML = `€ ${prices[0].innerHTML}`
    deposit.innerHTML = `1 monthly rent`
  } else if (parseInt(newDuration, 10) < 8) {
    price.innerHTML = `€ ${prices[1].innerHTML}`
    deposit.innerHTML = `2 monthy rents`
  } else {
    price.innerHTML = `€ ${prices[2].innerHTML}`
    deposit.innerHTML = `3 monthy rents`
  };
  info_fields.forEach((field) => {
    field.classList.add('changed');
  });
}

function addEventListenerToDuration() {
  const userUpdateInputField = document.querySelector('.user-update-input-field');
  if (userUpdateInputField) {
    const durationOptions = userUpdateInputField.querySelector('select');
    durationOptions.addEventListener('change', updatePricing);
  };
};

export { addEventListenerToDuration };
