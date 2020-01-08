// infoFieldWrapper is surrounding the Button and the Container
// infoOnHoverButton is the button that gets hovered
// infoFieldContainer contains the info and must be displayed when button is hovered

function addHoverEffect(infoFieldWrapper) {
  // hide info function
  // show info field
  const infoOnHoverButton = infoFieldWrapper.querySelector('.info-on-hover');
  const infoFieldContainer = infoFieldWrapper.querySelector('.info-field-container');
  // hover must be 2 functions, mouseover to show info and mouseout to hide info
  infoOnHoverButton.addEventListener('mouseover', function(){
    infoFieldContainer.classList.remove('d-none');
  });

  infoOnHoverButton.addEventListener('mouseout', function(){
    infoFieldContainer.classList.add('d-none');
  });
}

function infoOnHovering() {
  const infoFieldWrappers = document.querySelectorAll('.info-field-wrapper');
  if (infoFieldWrappers) {
    infoFieldWrappers.forEach((infoFieldWrapper) => {
      addHoverEffect(infoFieldWrapper);
    });
  };
}

export { infoOnHovering }
