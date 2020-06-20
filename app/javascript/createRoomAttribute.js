const removeRoom = event => {
  const parentDiv = event.currentTarget.closest('div');
  event.currentTarget.previousElementSibling.value = '1'; // hidden field _destroy
  parentDiv.classList.add('d-none');
  parentDiv.querySelector('.form-control').value = '';
  return event.preventDefault();
}


const addRoom = event => {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp(event.currentTarget.dataset.id, 'g');
  const target = event.currentTarget;
  // var insertIn = target.parentElement.lastElementChild; //field where the new form-field must be inserted
  target.previousElementSibling.insertAdjacentHTML('beforeend', event.currentTarget.dataset.fields.replace(regexp, time)); //insert form-field
  const allRoomFields = target.previousElementSibling.children
  const insertedElement = allRoomFields[allRoomFields.length - 1]
  var insertedAddButton = insertedElement.querySelector('.add_rooms');
  if (insertedAddButton) {insertedAddButton.addEventListener('click', addRoom)};

  var insertedRemoveButton = insertedElement.querySelector('.remove_room'); //inserted Remove_record Button
  insertedRemoveButton.addEventListener('click', removeRoom);

  target.previousElementSibling.scrollIntoView({behavior: "smooth", block: "end"});
  // console.log(target.offsetTop)
  // console.log(target.offsetTop - target.offsetHeight)
  // window.scrollTo(0, target.offsetTop - target.offsetHeight);
  return event.preventDefault();
}


function newRoomFieldHandler() {
  const form = document.querySelector('.simple_form');
  const addRoomButton = document.querySelectorAll('.add_rooms');
  const alreadyPresentRemoveRoomButtons = document.querySelectorAll('.remove_room');
  if (addRoomButton) {
    // form.addEventListener('click', removeRecord)
    addRoomButton.forEach((button) => { button.addEventListener('click', addRoom) });
    alreadyPresentRemoveRoomButtons.forEach((removeRoomButton) => {
      removeRoomButton.addEventListener('click', removeRoom)
    })
  }
}

export { newRoomFieldHandler }
