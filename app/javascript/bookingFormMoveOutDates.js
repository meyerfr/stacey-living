function deleteUnnecessaryDays() {
  const moveOutField = document.querySelector('.move_out_booking_form');
  if (moveOutField) {
    const moveOutDaySelect = document.getElementById('booking_move_out_3i');
    const dayOptions = moveOutDaySelect.children;
    const monthLength = dayOptions.length;
    var i;
    for(i = 0; i < monthLength-2; i++){
      if (i < 13) {
        dayOptions[0].remove();
      } else{
        dayOptions[1].remove();
      }
    }
  }
}

export { deleteUnnecessaryDays }
