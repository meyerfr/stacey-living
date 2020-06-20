import { monthDiff } from 'bookingDates';// maybe add 'from' if neccessary

const moveOut = document.querySelector('.booking_move_out');
const bookButton = document.querySelector('.book-button');
const bookButtonOverlay = document.getElementById('book-button-overlay');
const allOneAvaialabilityDivs = document.querySelectorAll('.one-availability');

function setCorrectMoveOutDate(moveInDate, moveOutDate, moveOutDateSelections) {
  if (monthDiff(moveInDate, moveOutDate) < 3) {
    const earliestMoveOutDate = moveInDate;
    earliestMoveOutDate.setMonth(earliestMoveOutDate.getMonth() + 3);
    moveOutDateSelections[0].value = earliestMoveOutDate.getDate();
    moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
    moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
    if (!moveOut.querySelector('.invalid-feedback')) {moveOut.insertAdjacentHTML('beforeend', '<div class="invalid-feedback d-block js-inserted">3 month duration minimum.</div>')};
  } else{
    return true
  }
}

const checkBookingForm = (event) => {
  const moveOutDateSelections = moveOut.querySelectorAll('select');
  const moveOutDate = new Date(parseInt(moveOutDateSelections[2].value), parseInt(moveOutDateSelections[1].value)-1, parseInt(moveOutDateSelections[0].value));

  if (document.querySelector('.rooms_availabilities').querySelector("input[type='checkBox']:checked")) {
    const moveInDate = new Date(document.querySelector("input[type='checkBox']:checked").nextElementSibling.innerText)
    if (setCorrectMoveOutDate(moveInDate, moveOutDate, moveOutDateSelections)){ // duration is >= 3
      if(moveOut.querySelector('.invalid-feedback')){moveOut.querySelector('.invalid-feedback').remove()};
      bookButton.disabled = false;
      if (event.currentTarget.id === 'book-button-overlay') {
        bookButton.click();
      }
    } else{
      bookButton.disabled = false;
    }
  } else{
    roomsAvailabilities.insertAdjacentHTML('beforeend', '<div class="invalid-feedback d-block js-inserted">Please click on a move in date.</div>');
  }
}

function addEventListeners() {
  if (bookButtonOverlay) {
    bookButtonOverlay.addEventListener('click', checkBookingForm)
    allOneAvaialabilityDivs.forEach((oneAvailability) => {oneAvailability.querySelector("input[type='checkBox']").addEventListener('click', checkBookingForm)})
  }
}

function checkBookingFormDuration() {
  if (moveOut) {
    addEventListeners();
  }
  // if (moveOut) {
  //   bookButtonOverlay.addEventListener('click', function(){
  //     const moveOutDateSelections = moveOut.querySelectorAll('select');
  //     const moveOutDate = new Date(parseInt(moveOutDateSelections[2].value), parseInt(moveOutDateSelections[1].value)-1, parseInt(moveOutDateSelections[0].value));
  //     const allOneAvaialabilityDivs = document.querySelectorAll('.one-availability');
  //     allOneAvaialabilityDivs.forEach((oneAvailability) => {
  //       if (oneAvailability.querySelector("input[type='checkBox']").checked) {
  //         const moveInDate = new Date(oneAvailability.querySelector('span').innerText)
  //         if (monthDiff(moveInDate, moveOutDate) < 3) {
  //           const earliestMoveOutDate = moveInDate;
  //           earliestMoveOutDate.setMonth(earliestMoveOutDate.getMonth() + 3);
  //           moveOutDateSelections[0].value = earliestMoveOutDate.getDate() - 1;
  //           moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
  //           moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
  //           if (!moveOut.querySelector('.invalid-feedback')) {moveOut.insertAdjacentHTML('beforeend', '<div class="invalid-feedback d-block js-inserted">3 month duration minimum.</div>')};
  //         } else{
  //           bookButton.disabled = false;
  //           bookButton.click();
  //         }
  //       } else{
  //         if (!moveOut.querySelector('.invalid-feedback') && !document.querySelector("input[type='checkBox']:checked")) {
  //           const roomsAvailabilities = document.querySelector('.rooms_availabilities');
  //           if (!roomsAvailabilities.children[roomsAvailabilities.children.length - 1].classList.contains('invalid-feedback')) {
  //             roomsAvailabilities.insertAdjacentHTML('beforeend', '<div class="invalid-feedback d-block js-inserted">Please click on a move in date.</div>');
  //           }
  //         }
  //       }
  //     })
  //   })
  // }
}

export { checkBookingFormDuration }
