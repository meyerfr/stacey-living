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

const instagram = (event) => {
  instagram_form.classList.remove("hidden");
  instagram_form.classList.add("editable");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  twitter_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
  linked_in_form.classList.remove("editable");
  twitter_form.classList.remove("editable");
  facebook_form.classList.remove("editable");
}

const checkInstagramUrl = () => {
  if (instagram_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    instagram_icon.classList.add('confirmed');
  }else {
    if (instagram_icon.classList.contains('confirmed')) {
      instagram_icon.classList.remove('confirmed');
    }
  }
}

const instagramButton = (event) => {
  instagram_form.classList.add("hidden");
  instagram_form.classList.remove("editable");
  checkInstagramUrl();
}


instagram_icon.addEventListener('click', instagram);
instagram_button.addEventListener('click', instagramButton);

const linkedIn = (event) => {
  linked_in_form.classList.remove("hidden");
  linked_in_form.classList.add("editable");
  // add hidden to all other forms and remove editable from all other forms
  twitter_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
  twitter_form.classList.remove("editable");
  instagram_form.classList.remove("editable");
  facebook_form.classList.remove("editable");
}

const checkLinkedInUrl = () => {
  if (linked_in_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    linked_in_icon.classList.add('confirmed');
  }else {
    if (linked_in_icon.classList.contains('confirmed')) {
      linked_in_icon.classList.remove('confirmed');
    }
  }
}

const linkedInButton = (event) => {
  linked_in_form.classList.add("hidden");
  linked_in_form.classList.remove("editable");
  checkLinkedInUrl();
}

linked_in_icon.addEventListener('click', linkedIn);
linked_in_button.addEventListener('click', linkedInButton);

const twitter = (event) => {
  twitter_form.classList.remove("hidden");
  twitter_form.classList.add("editable");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
  facebook_form.classList.add("hidden");
  linked_in_form.classList.remove("editable");
  instagram_form.classList.remove("editable");
  facebook_form.classList.remove("editable");
}

const checkTwitterUrl = () => {
  if (twitter_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    twitter_icon.classList.add('confirmed');
  }else {
    if (twitter_icon.classList.contains('confirmed')) {
      twitter_icon.classList.remove('confirmed');
    }
  }
}

const twitterButton = (event) => {
  twitter_form.classList.add("hidden");
  twitter_form.classList.remove("editable");
  checkTwitterUrl();
}

twitter_icon.addEventListener('click', twitter);
twitter_button.addEventListener('click', twitterButton);

const facebook = (event) => {
  facebook_form.classList.remove("hidden");
  facebook_form.classList.add("editable");
  // add hidden to all other forms and remove editable from all other forms
  linked_in_form.classList.add("hidden");
  twitter_form.classList.add("hidden");
  instagram_form.classList.add("hidden");
  linked_in_form.classList.remove("editable");
  twitter_form.classList.remove("editable");
  instagram_form.classList.remove("editable");
}

const checkFacebookUrl = () => {
  if (facebook_form.querySelector('.form-group').querySelector('.form-control').value != "") {
    facebook_icon.classList.add('confirmed');
  }else {
    if (facebook_icon.classList.contains('confirmed')) {
      facebook_icon.classList.remove('confirmed');
    }
  }
}

const facebookButton = (event) => {
  facebook_form.classList.add("hidden");
  facebook_form.classList.remove("editable");
  checkFacebookUrl();
}

facebook_icon.addEventListener('click', facebook);
facebook_button.addEventListener('click', facebookButton);


// twitter_icon.addEventListener('click', (event) => {
//   twitter_form.classList.remove("hidden");
//   twitter_form.classList.add("editable");
//   // add hidden to all other forms and remove editable from all other forms
//   linked_in_form.classList.add("hidden");
//   instagram_form.classList.add("hidden");
//   facebook_form.classList.add("hidden");
//   linked_in_form.classList.remove("editable");
//   instagram_form.classList.remove("editable");
//   facebook_form.classList.remove("editable");
// });


// If icons are clicked form is shown
// linked_in_icon.addEventListener('click', (event) => {
//   linked_in_form.classList.remove("hidden");
//   linked_in_form.classList.add("editable");
//   // add hidden to all other forms and remove editable from all other forms
//   twitter_form.classList.add("hidden");
//   instagram_form.classList.add("hidden");
//   facebook_form.classList.add("hidden");
//   twitter_form.classList.remove("editable");
//   instagram_form.classList.remove("editable");

// facebook_icon.addEventListener('click', (event) => {
//   facebook_form.classList.remove("hidden");
//   facebook_form.classList.add("editable");
//   // add hidden to all other forms and remove editable from all other forms
//   linked_in_form.classList.add("hidden");
//   twitter_form.classList.add("hidden");
//   instagram_form.classList.add("hidden");
//   linked_in_form.classList.remove("editable");
//   twitter_form.classList.remove("editable");
//   instagram_form.classList.remove("editable");
// });
//   facebook_form.classList.remove("editable");
// });


// instagram_icon.addEventListener('click', (event) => {
//   instagram_form.classList.remove("hidden");
//   instagram_form.classList.add("editable");
// twitter_button.addEventListener('click', (event) => {
//   witter_form.classList.add("hidden");
//   twitter_form.classList.remove("editable");t
// });
//   // add hidden to all other forms and remove editable from all other forms
//   linked_in_form.classList.add("hidden");
//   twitter_form.classList.add("hidden");
//   facebook_form.classList.add("hidden");
//   linked_in_form.classList.remove("editable");
//   twitter_form.classList.remove("editable");
facebook_button.addEventListener('click', (event) => {
  facebook_form.classList.add("hidden");
  facebook_form.classList.remove("editable");
});
//   facebook_form.classList.remove("editable");
// });

// If buttons are clicked the form gets hidden
// linked_in_button.addEventListener('click', (event) => {
//   linked_in_form.classList.add("hidden");
//   linked_in_form.classList.remove("editable");
// });


// instagram_button.addEventListener('click', (event) => {
//   instagram_form.classList.add("hidden");
//   instagram_form.classList.remove("editable");
// });

