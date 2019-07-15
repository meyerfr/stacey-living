const genderCheckBoxesInputs = document.querySelector('.gender').querySelectorAll('span');
const terms_and_conditions_check_box = document.querySelector('#terms-and-conditions');
const payment_button = document.querySelector('.payment-button');
const update_user_button = document.getElementById('update-user-button');
const overlay_button = document.getElementById('overlay-button');

function checkUserFormInputs() {
  let allFormInputs = document.getElementById('edit_user_1').querySelectorAll('.form-control');
  let boolean = false
  allFormInputs.forEach((input) => {
    if (input.value === '') {
      input.classList.add('error');
      console.log(input);
      boolean = true;
      // return true;
      // payment_button.disabled = true;
    } else{
      input.classList.remove('error');
      // return false;
      // payment_button.disabled = false;
    };
  });
  if (boolean === true) {
    return true;
  } else{
    return false;
  };
};

function checkTermsAndConditionsInput() {
  if (terms_and_conditions_check_box.checked === true) {
    // payment_button.disabled = false;
    document.querySelector('.terms-and-conditions').classList.remove('error');
    return false;
  } else{
    document.querySelector('.terms-and-conditions').classList.add('error');
    return true;
    // payment_button.disabled = true;
  };
}

function checkGenderInput() {
  let oneGenderChecked = false;
  genderCheckBoxesInputs.forEach((genderCheckBox) => {
    if (genderCheckBox.querySelector('input').checked === true) {
      oneGenderChecked = true;
    };
  });
  if (oneGenderChecked === false) {
    document.getElementById('gender-label').classList.add('error');
    // payment_button.disabled = true;
    return true;
  } else{
    document.getElementById('gender-label').classList.remove('error');
    // payment_button.disabled = false;
    return false;
  };
}

function checkIbanInput() {

}

const checkOnlyOneCheckBox = (event) => {
  let anyCheckBoxCicked = false;
  genderCheckBoxesInputs.forEach((genderCheckBox) => {
    genderCheckBox.querySelector('input').checked = false;
  });
  event.currentTarget.querySelector('input').checked = true;
}

function addEventListenerToGenderCheckBoxes() {
  genderCheckBoxesInputs.forEach((genderCheckBox) => {
    genderCheckBox.addEventListener("click", checkOnlyOneCheckBox);
  });
}

function makeTermsAndConditionsEverywhereClickable() {
  document.querySelector('.terms-and-conditions-label').addEventListener('click', function() {
    if (terms_and_conditions_check_box.checked) {
      terms_and_conditions_check_box.checked = false;
    } else{
      terms_and_conditions_check_box.checked = true;
    }
  })
}

const checkErrors = (event) => {
  // If no errors every Function returns false
  if (checkUserFormInputs() === false && checkGenderInput() === false && checkTermsAndConditionsInput() === false) {
    payment_button.disabled = false;
    update_user_button.click();
    payment_button.click();
  } else{
    console.log(checkUserFormInputs() === false);
    console.log(checkGenderInput() === false);
    console.log(checkTermsAndConditionsInput() === false);
    checkUserFormInputs();
    checkGenderInput();
    checkTermsAndConditionsInput();
  };
}

function checkBeforeSubmit() {
  addEventListenerToGenderCheckBoxes();
  makeTermsAndConditionsEverywhereClickable();
  overlay_button.addEventListener('click', checkErrors);
  // payment_button.addEventListener('click', checkAllInputs)
}

export{ checkBeforeSubmit };
// function addEventListenersToCheckBox() {
//   addEventListenerToGenderCheckBoxes();
//   terms_and_conditions_check_box.addEventListener('click', ablePaymentButton);
//   payment_button.addEventListener('click', checkInputs)
//   // payment_button.addEventListener('click', checkBeforeSubmit);
// };

// const checkInputs = (event) => {
//   // const inputsArray = [];
//   // document.querySelectorAll('input').forEach(function(input) {
//   //   if (input.type != 'hidden') {
//   //     inputsArray.push(input);
//   //   };
//   // });
//   // inputs.forEach(function(input) {
//   //     if (input.type) {}
//   // });
//   if (terms_and_conditions_check_box.checked === true) {
//     payment_button.disabled = false;
//     update_user_button.click();
//   } else{
//     payment_button.disabled = true;
//   };
//   checkAllInputs();
// }

// const checkBeforeSubmit = (event) => {
//   const inputs = document.querySelector('form').getElementsByTagName('input');
//   let i = 0;
//   let z = inputs.length;
//   let boolean = false;
//   // check if all inputs of the form are filles out. if boolean = true, inputs nicht alle ausgefüllt
//   while (i < z) {
//     if (inputs[i].value === ""){
//       boolean = true;
//       inputs[i].classList.add('error');
//       i = z;
//     } else{
//       i++;
//     };
//   };

//   // if boolean = true disable payment_button
//   if (boolean === true) {
//     payment_button.disabled = true;
//   } else{
//     payment_button.disabled = false;
//   };
// }

// const ablePaymentButton = (event) => {
//   if (terms_and_conditions_check_box.checked === true) {
//     payment_button.disabled = false;
//   } else{
//     payment_button.disabled = true;
//   };
// }
