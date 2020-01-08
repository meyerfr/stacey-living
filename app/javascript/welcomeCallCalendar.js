function expandConfirm() {
  const availableTimeButtons = document.querySelectorAll('.time-button');
  if (availableTimeButtons.length > 0) {
    availableTimeButtons.forEach((button) => {
      button.addEventListener('click', function(){
        event.currentTarget.classList.toggle('expanded');
        event.currentTarget.nextElementSibling.classList.toggle('not-expanded');
      })
    })
  }
}


function showUserInfo() {
  const detailButtons = document.querySelectorAll('.details')
  if (detailButtons.length > 0) {
    detailButtons.forEach((button) => {
      button.addEventListener('click', function(){
        event.currentTarget.parentElement.nextElementSibling.classList.toggle('d-none');
        event.currentTarget.children[0].classList.toggle('d-none');
        event.currentTarget.children[1].classList.toggle('d-none');
      })
    })
  }
}

export { expandConfirm }
export { showUserInfo }
