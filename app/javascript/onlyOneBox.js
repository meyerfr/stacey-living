function onlyOneBox() {
  var checkBoxesContainers = document.querySelectorAll('.only-one-box');
  if (checkBoxesContainers.length > 0 ) {
    checkBoxesContainers.forEach((checkBoxContainer) => {
      const allCheckBoxes = checkBoxContainer.querySelectorAll("input[type='checkBox']");
      allCheckBoxes.forEach((checkBox) => {
        checkBox.addEventListener('click', function(){
          if (event.currentTarget.checked === true) {
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
