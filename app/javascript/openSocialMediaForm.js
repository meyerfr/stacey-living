var linked_in_icon = document.querySelector('#linked-in-icon');
var twitter_icon = document.querySelector('#twitter-icon');
var instagram_icon = document.querySelector('#instagram-icon');
var facebook_icon = document.querySelector('#facebook-icon');

var linked_in_form = document.querySelector('#linked-in-form');
var twitter_form = document.querySelector('#twitter-form');
var instagram_form = document.querySelector('#instagram-form');
var facebook_form = document.querySelector('#facebook-form');

var linked_in_button = document.querySelector('.social-button-linked-in');
var twitter_button = document.querySelector('.social-button-twitter');
var instagram_button = document.querySelector('.social-button-instagram');
var facebook_button = document.querySelector('.social-button-facebook');

// Instagram
function checkInstagramUrl() {
  if (instagram_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    instagram_icon.classList.add('confirmed');
  }else {
    if (instagram_icon.classList.contains('confirmed')) {
      instagram_icon.classList.remove('confirmed');
    }
  }
}

instagram_icon.addEventListener("click", function (event) {
  instagram_form.classList.remove("hidden");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  twitter_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
});

instagram_button.addEventListener("click", function (event) {
  instagram_form.classList.add("hidden");
  checkInstagramUrl();
});

// linkedIn
function checkLinkedInUrl() {
  if (linked_in_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    linked_in_icon.classList.add('confirmed');
  }else {
    if (linked_in_icon.classList.contains('confirmed')) {
      linked_in_icon.classList.remove('confirmed');
    }
  }
}

linked_in_icon.addEventListener("click", function (event) {
  linked_in_form.classList.remove("hidden");
  // add hidden to all other forms and remove editable from all other forms
  twitter_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
});

linked_in_button.addEventListener("click", function (event) {
  linked_in_form.classList.add("hidden");
  checkLinkedInUrl();
});

// twitter
function checkTwitterUrl() {
  if (twitter_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    twitter_icon.classList.add('confirmed');
  }else {
    if (twitter_icon.classList.contains('confirmed')) {
      twitter_icon.classList.remove('confirmed');
    }
  }
}

twitter_icon.addEventListener("click", function (event) {
  twitter_form.classList.remove("hidden");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
});

twitter_button.addEventListener("click", function (event) {
  twitter_form.classList.add("hidden");
  checkTwitterUrl();
});

// facebook
function checkFacebookUrl() {
  if (facebook_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    facebook_icon.classList.add('confirmed');
  }else {
    if (facebook_icon.classList.contains('confirmed')) {
      facebook_icon.classList.remove('confirmed');
    }
  }
}

facebook_icon.addEventListener("click", function (event) {
  facebook_form.classList.remove("hidden");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  twitter_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
});

facebook_button.addEventListener("click", function (event) {
  facebook_form.classList.add("hidden");
  checkFacebookUrl();
});
