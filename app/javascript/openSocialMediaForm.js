const linked_in_icon = document.querySelector('#linked-in-icon');
const twitter_icon = document.querySelector('#twitter-icon');
const instagram_icon = document.querySelector('#instagram-icon');
const facebook_icon = document.querySelector('#facebook-icon');

const linked_in_form = document.querySelector('#linked-in-form');
const twitter_form = document.querySelector('#twitter-form');
const instagram_form = document.querySelector('#instagram-form');
const facebook_form = document.querySelector('#facebook-form');

const linked_in_button = document.querySelector('.social-button-linked-in');
const twitter_button = document.querySelector('.social-button-twitter');
const instagram_button = document.querySelector('.social-button-instagram');
const facebook_button = document.querySelector('.social-button-facebook');

const instagramIcon = (event) => {
  event.preventDefault();
  instagram_form.classList.toggle('hidden');
  linked_in_form.classList.add('hidden');
  twitter_form.classList.add('hidden');
  facebook_form.classList.add('hidden');
}

const instagramUrl = (event) => {
  event.preventDefault();
  instagram_form.classList.add('hidden');
  if (instagram_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    instagram_icon.classList.add('confirmed');
  }else {
    if (instagram_icon.classList.contains('confirmed')) {
      instagram_icon.classList.remove('confirmed');
    }
  }
}

const linkedInIcon = (event) => {
  event.preventDefault();
  linked_in_form.classList.toggle('hidden');
  instagram_form.classList.add('hidden');
  twitter_form.classList.add('hidden');
  facebook_form.classList.add('hidden');
}

const linkedInUrl = (event) => {
  event.preventDefault();
  linked_in_form.classList.add('hidden');
  if (linked_in_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    linked_in_icon.classList.add('confirmed');
  }else {
    if (linked_in_icon.classList.contains('confirmed')) {
      linked_in_icon.classList.remove('confirmed');
    }
  }
}

const facebookIcon = (event) => {
  event.preventDefault();
  facebook_form.classList.toggle('hidden');
  linked_in_form.classList.add('hidden');
  instagram_form.classList.add('hidden');
  twitter_form.classList.add('hidden');
}

const facebookUrl = (event) => {
  event.preventDefault();
  facebook_form.classList.add('hidden');
  if (facebook_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    facebook_icon.classList.add('confirmed');
  }else {
    if (facebook_icon.classList.contains('confirmed')) {
      facebook_icon.classList.remove('confirmed');
    }
  }
}

const twitterIcon = (event) => {
  event.preventDefault();
  twitter_form.classList.toggle('hidden');
  linked_in_form.classList.add('hidden');
  instagram_form.classList.add('hidden');
  facebook_form.classList.add('hidden');
}

const twitterUrl = (event) => {
  event.preventDefault();
  twitter_form.classList.add('hidden');
  if (twitter_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    twitter_icon.classList.add('confirmed');
  }else {
    if (twitter_icon.classList.contains('confirmed')) {
      twitter_icon.classList.remove('confirmed');
    }
  }
}

function addEventListenerToAllSocialMediaInputs() {
  if (instagram_icon){
    instagram_icon.addEventListener('click', instagramIcon);
    instagram_button.addEventListener('click', instagramUrl);
    linked_in_icon.addEventListener('click', linkedInIcon);
    linked_in_button.addEventListener('click', linkedInUrl);
    facebook_icon.addEventListener('click', facebookIcon);
    facebook_button.addEventListener('click', facebookUrl);
    twitter_icon.addEventListener('click', twitterIcon);
    twitter_button.addEventListener('click', twitterUrl);
  }
};

export { addEventListenerToAllSocialMediaInputs };
