const moveIn = document.querySelector('.user_bookings_move_in');
const moveOut = document.querySelector('.user_bookings_move_out');

function monthDiff(d1, d2) {
  var months;
  months = (d2.getFullYear() - d1.getFullYear()) * 12;
  months -= d1.getMonth() + 1;
  months += d2.getMonth() + 1;
  return months <= 0 ? 0 : months;
}

// check if movin date is in the future
const checkMoveInDate = (event) => {
  var moveInDateSelections = moveIn.children[1].children;
  const moveInDate = new Date(parseInt(moveInDateSelections[2].value), parseInt(moveInDateSelections[1].value)-1, parseInt(moveInDateSelections[0].value)+1);
  if (moveInDate <= new Date() && moveIn.childElementCount < 3) {
    moveIn.children[1].insertAdjacentHTML('afterend', '<div class="invalid-feedback d-block js-inserted">Can´t choose a Date in the past.</div>');
  } else if (moveInDate > new Date() && moveIn.childElementCount === 3) {
    moveIn.children[2].remove();
  }
    // adjusting moveOut date
  const moveOutDateSelections = moveOut.children[1].children;
  const moveOutDate = new Date(parseInt(moveOutDateSelections[2].value), parseInt(moveOutDateSelections[1].value)-1, parseInt(moveOutDateSelections[0].value));
  const duration = monthDiff(moveInDate, moveOutDate);
  if (duration < 3) {
    const earliestMoveOutDate = moveInDate;
    earliestMoveOutDate.setMonth(earliestMoveOutDate.getMonth() + 3);
    moveOutDateSelections[0].value = earliestMoveOutDate.getDate() - 1;
    moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
    moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
  } else if (moveOut.childElementCount === 3) {
    moveOut.children[2].remove();
  }
}

const checkMoveOutDate = (event) => {
  var moveInDateSelections = moveIn.children[1].children;
  const moveInDate = new Date(parseInt(moveInDateSelections[2].value), parseInt(moveInDateSelections[1].value)-1, parseInt(moveInDateSelections[0].value));

  var moveOutDateSelections = moveOut.children[1].children;
  const moveOutDate = new Date(parseInt(moveOutDateSelections[2].value), parseInt(moveOutDateSelections[1].value)-1, parseInt(moveOutDateSelections[0].value));
  const duration = monthDiff(moveInDate, moveOutDate);

  const earliestMoveOutDate = moveInDate;
  earliestMoveOutDate.setMonth(earliestMoveOutDate.getMonth() + 3);
  console.log(moveOutDate)
  if (duration < 3) {
    if (moveOut.childElementCount < 3) {
      moveOut.children[1].insertAdjacentHTML('afterend', `<div class="invalid-feedback d-block js-inserted">Can´t move in on the ${moveOutDate.toLocaleDateString()}. 3 Month minimum.</div>`);
      moveOutDateSelections[0].value = earliestMoveOutDate.getDate() - 1;
      moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
      moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
    } else{
      moveOut.children[2].remove();
      moveOut.children[1].insertAdjacentHTML('afterend', `<div class="invalid-feedback d-block js-inserted">Can´t move in on the ${moveOutDate.toLocaleDateString()}. 3 Month minimum.</div>`);
      moveOutDateSelections[0].value = earliestMoveOutDate.getDate() - 1;
      moveOutDateSelections[1].value = earliestMoveOutDate.getMonth() + 1;
      moveOutDateSelections[2].value = earliestMoveOutDate.getFullYear();
    }
  } else if (duration >= 3 && moveOut.childElementCount === 3) {
    moveOut.children[2].remove();
  }
}

function checkDates() {
  if (moveIn) {
    var moveInDateSelections = moveIn.children[1].children;
    Array.from(moveInDateSelections).forEach((select) => {
      select.addEventListener('change', checkMoveInDate);
    })
  }
  if (moveOut) {
    var moveOutDateSelections = moveOut.children[1].children;
    Array.from(moveOutDateSelections).forEach((select) => {
      select.addEventListener('change', checkMoveOutDate);
    })
  }
}

export { checkDates }
