function onlyOneBox() {
  var checkBoxesContainers = document.querySelectorAll('.only-one-box');
  if (checkBoxesContainers.length > 0 ) {
    checkBoxesContainers.forEach((checkBoxContainer) => {
      const allCheckBoxes = checkBoxContainer.querySelectorAll("input[type='checkBox']");
      allCheckBoxes.forEach((checkBox) => {
        checkBox.addEventListener('click', function(){
          if (event.currentTarget.checked === true) {
            var bookButton = document.querySelector('.book-button');
            if (bookButton) {
              const moveInDateSelections = document.querySelector('.booking_move_in').querySelector('select');
              const moveInDate = new Date(checkBox.nextElementSibling.innerText);
              moveInDateSelections[0].value = moveInDate.getDate() - 1;
              moveInDateSelections[1].value = moveInDate.getMonth() + 1;
              moveInDateSelections[2].value = moveInDate.getFullYear();
              bookButton.value = event.currentTarget.value;
            }
            allCheckBoxes.forEach((checkBox) => {
              if (checkBox != event.currentTarget) {
                checkBox.checked = false;
              }
            })
          }
        })
      })
    })
  }
}

export { onlyOneBox }
