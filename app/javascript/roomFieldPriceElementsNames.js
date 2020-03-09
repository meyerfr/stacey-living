import { insertPictures } from 'imagePreview'

const changeRoomFieldNames = event => {
  var previousInput = event.currentTarget.parentElement.previousElementSibling;
  var correctPriceElementName = previousInput.querySelector('.hidden').name.replace('[_destroy]', '[price]');
  var correctPriceElementId = previousInput.querySelector('.hidden').id.replace('_destroy', 'price');
  var priceElements = previousInput.querySelector('.prices').querySelectorAll('input');
  for (var i = priceElements.length - 1; i >= 0; i--) {
    priceElements[i].name = correctPriceElementName + `[]`
    priceElements[i].id = correctPriceElementId + `_${i}`
  }

  var correctAmenityElementName = previousInput.querySelector('.hidden').name.replace('[_destroy]', '[room_amenities_attributes]');
  var correctAmenityElementId = previousInput.querySelector('.hidden').id.replace('_destroy', 'room_amenities_attributes');
  var amenityElements = previousInput.querySelector('.project-amenities').querySelectorAll('input');
  for (var i = amenityElements.length - 1; i >= 0; i--) {
    amenityElements[i].name = correctAmenityElementName + `[${i}][amenity_id]`
    amenityElements[i].id = correctAmenityElementId + `_${i}_amenity_id`
  }

  // addEventListener to Picture Upload
  previousInput.querySelector('.picture-upload').addEventListener('change', insertPictures)
}

function checkPricesNames() {
  var addRoomButton = document.querySelector('.add_fields');
  if (addRoomButton) {
    addRoomButton.addEventListener('click', changeRoomFieldNames)
  }
}

export { checkPricesNames }
