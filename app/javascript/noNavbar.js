function noNavbar() {
  const noNavbarItem = document.querySelector('.no-navbar');
  if (noNavbarItem) {
    noNavbarItem.previousElementSibling.remove();
  }
}

export { noNavbar }
