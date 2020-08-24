const updateAttendanceView = (target) => { //target is either attended button or not-attended button
  if (target.classList.contains('attended')) {
    target.nextElementSibling.classList.remove('red');
    target.classList.add('green');
  } else{
    target.previousElementSibling.classList.remove('green');
    target.classList.add('red');
  }
}

const changeAttendance = (event) => {
  event.preventDefault();
  const target = event.currentTarget;
  const formData = new FormData()
  const welcome_call_id = target.parentElement.children[0].innerText
  console.log(welcome_call_id);
  formData.append('id', welcome_call_id)
  if (event.currentTarget.classList.contains('attended')) {
    formData.append('attendance', 'true')
  } else{
    formData.append('attendance', 'false')
  }
  fetch(`/change_attendance`, {
    method: 'PATCH',
    headers: {
      'Accept' : 'application/json'
    },
    body: formData
  })
  .then(response => response.json())
  .then(data => {
    updateAttendanceView(target);
  })
}

function addEventListenerToAttendanceButtons() {
  const attendanceButtons = document.querySelectorAll('.attendance-button');
  if (attendanceButtons.length > 0) {
    attendanceButtons.forEach((button) => {
      button.addEventListener('click', changeAttendance)
    })
  }
}

export { addEventListenerToAttendanceButtons }
