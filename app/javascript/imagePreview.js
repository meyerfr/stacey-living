const imagePreviews = document.querySelectorAll('.img_prev');

// $(function() {
//   function readURL(input) {
//     if (input.files && input.files[0]) {
//       var reader = new FileReader();

//       reader.onload = function (e) {
//         $('#img_prev').attr('src', e.target.result);
//       }
//       reader.readAsDataURL(input.files[0]);
//     }
//   }

//   $("#avatar-upload").change(function(){
//     $('#img_prev').removeClass('hidden');
//     readURL(this);
//   });
// });

// function readURL(input) {
//   if (input.files && input.files[0]) {
//     // var reader = new FileReader();

//     // reader.onload = function (e) {
//     // }
//   }
// }

const insertPictures = (event) => {
  // imagePreview.classList.remove('d-none');
  // console.log(event.target)
  if (event.target.files && event.target.files[0]) {
    var files = event.target.files
    for (var i = 0; i < files.length; i++) {
      (function(file) {
        var reader = new FileReader();
        var target = event.target;
        reader.onload = function (e) {
          console.log(e)
          console.log(target)
          // event.target.files.forEach((file) => {
          target.parentElement.previousElementSibling.insertAdjacentHTML('afterbegin', `<img width=300 height=300 src=${e.target.result} alt="Project Image" class="img-thumbnail"/>`);
          // })
          //console.log(e.target.result)
          // imagePreview.src = e.target.result;
        };
        reader.readAsDataURL(file)
      })(files[i]);
    }
  }
  // console.log(event.target)
};


// var files = document.getElementById("images").files;

// for (var i = 0; i < files.length; i++) {
//   // Closure to capture the file information.
//   (function(file) {
//     var reader = new FileReader();
//     reader.onload = function(e) {
//       // Render thumbnail.
//       var span = document.createElement('span');
//       span.innerHTML = ['<img src="', e.target.result,
//         '" title="', escape(file.name), '">'
//       ].join('');
//       document.getElementById('list').insertBefore(span, null);
//     };
//     // Read in the image file as a data URL.
//     reader.readAsDataURL(file);
//   })(files[i]);
// }


function previewImages() {
  if (imagePreviews) {
    document.querySelectorAll('.picture-upload').forEach((upload) => {
      upload.addEventListener('change', insertPictures)
    })
  }
};

export { previewImages };
export { insertPictures };
// <img id="img_prev" width=300 height=300 src="#" alt="your image" class="img-thumbnail d-none"/> <br/>
