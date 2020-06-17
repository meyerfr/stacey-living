// function checkCoupleSelection() {
//   const coupleSelectionWrapper = document.querySelector('.user_amount_of_people');
//   if (coupleSelectionWrapper) {
//     const preferedSuiteCheckBoxes = document.querySelectorAll('input[name="user[prefered_suite][]"]');
//     const checkedBoxes = []
//     preferedSuiteCheckBoxes.forEach((checkBox) => {
//       if (checkBox.checked) {
//         checkedBoxes.pop(checkBox.value)
//       }
//     })
//     coupleSelectionWrapper.children[1].addEventListener('click', function(){
//       if (checkedBoxes.contains('Jumbo')) {

//       }
//     })
//   }
// }

function addCoupleOption() {
  const jumboCheckBox = document.querySelector('.prefered-suites-jumbo');
  if (jumboCheckBox) {
    jumboCheckBox.addEventListener('click', function(){
      const coupleSelection = document.getElementById('booking_user_attributes_amount_of_people');
      if (jumboCheckBox.checked) {
        coupleSelection.insertAdjacentHTML('afterbegin', '<option value="2">YES</option>');
      } else{
        coupleSelection.children[0].remove();
      }
    })
  }
}

export { addCoupleOption }
