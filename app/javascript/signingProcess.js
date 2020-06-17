function signing() {
  const nextButton = document.getElementById('sign-next-button');
  if (nextButton) {
    const allChangeFormButtons = document.querySelectorAll('.change-form');
    allChangeFormButtons.forEach((button) => {
      button.addEventListener('click', function(){
        // This function changes the Form
        document.querySelectorAll('.contract-user-inputs').forEach((input) => {
          input.classList.toggle('d-none');
        });
        allChangeFormButtons.forEach((button) => {
          button.classList.toggle('d-none');
        });
        document.querySelector('.signature-fields').classList.toggle('d-none');
        document.querySelector('.sign-button').classList.toggle('d-none');
      });
    });
  };
};

export{ signing }
