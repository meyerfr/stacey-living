function signing() {
  const nextButton = document.getElementById('sign-next-button');
  if (nextButton) {
    nextButton.addEventListener('click', function(){
      document.querySelectorAll('.contract-user-inputs').forEach((input) => {
        input.classList.add('d-none');
      });
      nextButton.classList.add('d-none');
      document.querySelector('.signature-fields').classList.remove('d-none');
      nextButton.nextElementSibling.classList.remove('d-none');
    });
  };
}

export{ signing }
