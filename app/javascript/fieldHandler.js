const removeRecord = event => {
  const parentDiv = event.currentTarget.closest('div')
  event.currentTarget.previousElementSibling.value = '1'; // hidden field _destroy
  parentDiv.parentElement.classList.add('d-none');
  parentDiv.querySelector('.form-control').value = '';
  return event.preventDefault();
}


const addFields = event => {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp(event.currentTarget.dataset.id, 'g');
  const target = event.currentTarget;
  // var insertIn = target.parentElement.lastElementChild; //field where the new form-field must be inserted
  target.parentElement.insertAdjacentHTML('beforebegin', event.currentTarget.dataset.fields.replace(regexp, time)); //insert form-field
  var insertedRemoveButton = target.parentElement.previousElementSibling.querySelector('.remove_record'); //inserted Remove_record Button
  if (insertedRemoveButton) insertedRemoveButton.addEventListener('click', removeRecord);

  var insertedAddRoomattributeButton = document.querySelector('.add-room-type').parentElement.previousElementSibling.querySelector('.add_fields');
  if (insertedAddRoomattributeButton) insertedAddRoomattributeButton.addEventListener('click', addFields);

  target.parentElement.previousElementSibling.scrollIntoView({behavior: "smooth", block: "start"});
  // console.log(target.offsetTop)
  // console.log(target.offsetTop - target.offsetHeight)
  // window.scrollTo(0, target.offsetTop - target.offsetHeight);
  return event.preventDefault();
}


function fieldHandler() {
  const form = document.querySelector('.simple_form');
  const addRoomButton = document.querySelectorAll('.add_fields');
  const alreadyPresentRemoveFieldButtons = document.querySelectorAll('.remove_record');
  if (addRoomButton) {
    // form.addEventListener('click', removeRecord)
    addRoomButton.forEach((button) => { button.addEventListener('click', addFields) });
    alreadyPresentRemoveFieldButtons.forEach((removeFieldButton) => {
      removeFieldButton.addEventListener('click', removeRecord)
    })
  }
}

export { fieldHandler }
