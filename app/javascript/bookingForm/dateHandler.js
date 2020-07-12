// handle moveOut flatpickr
// minDate & maxDate must change if move_in changes

var moveInField = document.getElementById('booking_room_id');

function get_move_in_date() {
  return new Date(moveInField.selectedOptions[0].text);
};

function get_move_out_date() {
  const moveOutFlatpickr = document.querySelector('#move_out_flatpickr')._flatpickr;
  if (moveOutFlatpickr.selectedDates.length > 0) {
    return moveOutFlatpickr.selectedDates[0]
  };
};

var moveInDate = get_move_in_date();
var earliestMoveOutDate = new Date(moveInDate.getFullYear(), moveInDate.getMonth()+3, moveInDate.getDate());

function monthDiff(d1, d2) {
  return(d2.getFullYear() - d1.getFullYear()) * 12 + (d2.getMonth() + 1) - (d1.getMonth() + 1) - ((d2.getDate() >= d1.getDate()) ? 0 : 1);
};

const changeMoveOutFlatpickrAttributes = (event) => {
  var newMoveInDate = new Date(moveInField.selectedOptions[0].text);
  var earliestMoveInDate = new Date(newMoveInDate.setMonth(newMoveInDate.getMonth()+3));
  const moveOutFlatpickr = document.querySelector('#move_out_flatpickr')._flatpickr;
  moveOutFlatpickr.set('minDate', earliestMoveInDate)
  moveOutFlatpickr.set('maxDate', earliestMoveInDate.fp_incr(485))
  // the changing of month fixes the bug of the disappearing monthList when it jumps to the next Year.
  moveOutFlatpickr.changeMonth(12);
  moveOutFlatpickr.changeMonth(-12);
};

const changePrice = (event) => {
  const bookingPrice = document.getElementById('booking-price');
  if (bookingPrice) {
    const allRoomtypePrices = document.getElementById('all-prices').children;
    const moveInDate = get_move_in_date();
    const moveOutDate = get_move_out_date();
    if (moveInDate && moveOutDate) {
      const duration = monthDiff(moveInDate, moveOutDate);
      if (duration >= 9) {
        bookingPrice.innerText = allRoomtypePrices[2].innerText
      } else if(duration >= 6){
        bookingPrice.innerText = allRoomtypePrices[1].innerText
      } else{
        bookingPrice.innerText = allRoomtypePrices[0].innerText
      };
    }
  };
};

function addEventListenersToDateField() {
  if (moveInField) {
    moveInField.addEventListener('change', changeMoveOutFlatpickrAttributes);
    moveInField.addEventListener('change', changePrice);
    const moveOutFlatpickr = document.querySelector('#move_out_flatpickr')._flatpickr;
    moveOutFlatpickr.set('onChange', changePrice);
  };
};

export { addEventListenersToMoveInField };
