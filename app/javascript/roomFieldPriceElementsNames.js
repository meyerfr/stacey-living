const changePricesNames = event => {
  var previousInput = event.currentTarget.previousElementSibling;
  var correctName = previousInput.querySelector('.hidden').name.replace('[_destroy]', '[price]');
  var correctId = previousInput.querySelector('.hidden').id.replace('_destroy', 'price');
  var priceElements = previousInput.querySelector('.prices').querySelectorAll('input');
  for (var i = priceElements.length - 1; i >= 0; i--) {
    priceElements[i].name = correctName + `[]`
    priceElements[i].id = correctId + `_${i}`
  }
}

function checkPricesNames() {
  var addRoomButton = document.querySelector('.add_fields');
  if (addRoomButton) {
    addRoomButton.addEventListener('click', changePricesNames)
  }
}

export { checkPricesNames }
