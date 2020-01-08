const onlyOneSocialMediaInput = (event) => {
  const socialMediaInputs = document.querySelectorAll('.social-media-input');
  var correctInputClass = event.currentTarget.classList[3]
  socialMediaInputs.forEach((input) => {
    if (input.classList.contains(`user_${correctInputClass}`)) {
      if (input.classList.contains('d-none')) {
        input.classList.remove('d-none');
        input.children[0].select();
      } else{
        input.classList.add('d-none');
      }
    } else if (!input.classList.contains('d-none')) {
      input.classList.add('d-none');
    }
  })
}

function socialMediaForms() {
  const socialMediaIcons = document.querySelectorAll('.social-media-icon');
  if (socialMediaIcons.length > 0) {
    socialMediaIcons.forEach((icon) => {
      icon.addEventListener('click', onlyOneSocialMediaInput)
    })
  }
}

export { socialMediaForms }
