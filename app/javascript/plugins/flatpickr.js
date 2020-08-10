import flatpickr from "flatpickr";
import {get_move_in_date} from '../bookingForm/dateHandler';

var moveInField = document.getElementById('booking_room_id');
if (moveInField) {
  const moveInDate = get_move_in_date();
  var earliestMoveOutDate = new Date(moveInDate.getFullYear(), moveInDate.getMonth()+3, moveInDate.getDate())

  const moveOutFlatpickr = flatpickr(".datepicker", {
    altInput: true,
    altFormat: "d.m.Y",
    dateFormat: "Y-m-d",
    enable: [
      function(date) {
        // return true to enable
        return (date.getDate() === 14 || date.getDate() === (new Date(date.getFullYear(), date.getMonth()+1, 0)).getDate());
      }
    ],
    locale: {
      firstDayOfWeek: 1 // start week on Monday
    },
    minDate: earliestMoveOutDate,
    maxDate: earliestMoveOutDate.fp_incr(485)
  });
}
