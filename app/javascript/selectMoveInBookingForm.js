import { monthDiff } from 'bookingDates';

const updateDates = (event) => {
  const moveInField = document.getElementById('booking_move_in');
  const moveInDate = new Date(document.querySelector('#booking_room_id').selectedOptions[0].text);
  moveInField.value = moveInDate;

  const moveOutField = document.querySelector('.booking_move_out');
  const moveOutDateSelections = moveOutField.children[1].children;
  const previousMoveOutDate = new Date(parseInt(moveOutDateSelections[2].value), parseInt(moveOutDateSelections[1].value)-1, parseInt(moveOutDateSelections[0].value));
  const duration = monthDiff(moveInDate, previousMoveOutDate);
  if (duration < 3) {
    const earliestMoveOutDate = moveInDate;
    earliestMoveOutDate.setMonth(earliestMoveOutDate.getMonth() + 3);
    if (moveOutField.childElementCount >= 3) {
      moveOutField.children[2].remove();
    }
    moveOutField.children[1].insertAdjacentHTML('afterend', `<div class="invalid-feedback d-block js-inserted">Can´t move in on the ${previousMoveOutDate.toLocaleDateString()}. 3 Month minimum.</div>`);
    moveOutDateSelections[0].value = earliestMoveOutDate.getDate();
    moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
    moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
  } else if (duration >= 3 && moveOutField.childElementCount === 3) {
    moveOutField.children[2].remove();
  }
}

function selectMoveInDate() {
  const moveInSelectField = document.getElementById('booking_room_id');
  const moveOut = document.querySelector('.booking_move_out');
  if (moveInSelectField) {
    moveInSelectField.addEventListener('change', updateDates)
    var moveOutDateSelections = moveOut.children[1].children;
    Array.from(moveOutDateSelections).forEach((select) => {
      select.addEventListener('change', updateDates);
    })
  }
}

export { selectMoveInDate }