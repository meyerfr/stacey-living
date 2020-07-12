import flatpickr from "flatpickr";

var moveInField = document.getElementById('booking_room_id');
var moveInDate = new Date(moveInField.selectedOptions[0].text)
var earliestMoveOutDate = new Date(moveInDate.getFullYear(), moveInDate.getMonth()+3, moveInDate.getDate())

const moveOutFlatpickr = flatpickr(".datepicker", {
  altInput: true,
  altFormat: "d.m Y",
  dateFormat: "Y-m-d",
  enable: [
    function(date) {
      // return true to disable
      return (date.getDate() === 14 || date.getDate() === (new Date(date.getFullYear(), date.getMonth()+1, 0)).getDate());
      // return (day >= 2 && day <= 14 || day >= 16 && day <= 31);
    }
  ],
  locale: {
    firstDayOfWeek: 1 // start week on Monday
  },
  minDate: earliestMoveOutDate,
  maxDate: earliestMoveOutDate.fp_incr(485)
});
