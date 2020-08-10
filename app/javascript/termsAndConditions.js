const removeTaCError = (event) => {
  const termsAndConditionsError = document.querySelector('.terms-and-conditions-error')
  if (event.currentTarget.checked && termsAndConditionsError) {
    termsAndConditionsError.parentElement.setAttribute("style", "margin-bottom: unset;");
    termsAndConditionsError.remove()
  }
}

function addEventListenerToTaC() {
  const termsAndConditionsInput = document.getElementById('terms-and-conditions');
  if (termsAndConditionsInput) {
    termsAndConditionsInput.addEventListener('change', removeTaCError)
  }
}

export { addEventListenerToTaC }
