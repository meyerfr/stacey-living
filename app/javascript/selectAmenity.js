const selectOrDisselectAmenity = (event) => {
  var target = event.currentTarget
  console.log(target)
  if (target.classList.contains('selected')) {
    target.children[0].value = 1
  } else {
    target.children[0].value = 0
  }
  target.classList.toggle('selected')
}

function addEventListenerToAmenityField(amenityField) {
  amenityField.addEventListener('click', selectOrDisselectAmenity)
}

function selectAmenity() {
  const allAmenityWrappers = document.querySelectorAll('.amenity-wrapper');
  if (allAmenityWrappers.length > 0) {
    allAmenityWrappers.forEach((amenityWrapper) => {
      const allAmenityFields = amenityWrapper.querySelectorAll('.amenity-field');
      allAmenityFields.forEach((amenityField) => {
        addEventListenerToAmenityField(amenityField);
      })
    })
  }
}

export { selectAmenity }
export { addEventListenerToAmenityField }
