const attendanceButtons = document.querySelectorAll('.attendance-button');

const updateAttendanceView = (attendance) => {
  attendanceButtons.forEach((button) => {
    if (button.classList.contains('attended')) {
      if (attendance === true) {
        button.classList.add('green')
      } else{
        button.classList.remove('green')
      }
    } else{
      if (attendance === false) {
        button.classList.add('red')
      } else{
        button.classList.remove('red')
      }
    }
  })
}

const changeAttendance = (event) => {
  event.preventDefault();
  const formData = new FormData()
  const welcome_call_id = document.getElementById('welcome_call_id').innerText
  formData.append('id', welcome_call_id)
  if (event.currentTarget.classList.contains('attended')) {
    formData.append('attendance', 'true')
  } else{
    formData.append('attendance', 'false')
  }
  fetch(`http://localhost:3000/change_attendance`, {
    method: 'PATCH',
    headers: {
      'Accept' : 'application/json'
    },
    body: formData
  })
  .then(response => response.json())
  .then(data => {
    updateAttendanceView(data['attendance']);
  })
}

function addEventListenerToAttendanceButtons() {
  if (attendanceButtons.length > 0) {
    attendanceButtons.forEach((button) => {
      button.addEventListener('click', changeAttendance)
    })
  }
}

export { addEventListenerToAttendanceButtons }
