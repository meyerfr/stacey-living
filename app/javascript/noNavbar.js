function noNavbar() {
  const noNavbarItem = document.querySelector('.no-navbar');
  if (noNavbarItem) {
    noNavbarItem.previousElementSibling.classList.add('d-none');
  }
}

export { noNavbar }
