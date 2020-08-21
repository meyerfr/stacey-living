const updateUserInfo = (event) => {

}

const openUserModal = (event) => {
  const target = event.currentTarget;
  const user_id = target.dataset.value;
  const modal = $('.modal');
  fetch(`/users/${user_id}`, {
    method: 'GET',
    headers: {
      'Accept' : 'application/json'
    }
  })
  .then(response => response.json())
  .then(data => {
    console.log(data)
    updateUserInfo(data)
    // modal.modal('show');
    // $(".modal").html("$<%= j render(:partial => 'shared/modal_partial', :locals => { user: data.user }) %>");
    // modal.modal('show');
  })
}

function addEventListenerToListContextContainer() {
  const allListContextContainer = document.querySelectorAll('.user-info-container')
  allListContextContainer.forEach((container) => {
    container.addEventListener('click', openUserModal)
  })
}

export { addEventListenerToListContextContainer }
