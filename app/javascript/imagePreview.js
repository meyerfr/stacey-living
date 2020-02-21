const imagePreview = document.getElementById('img_prev');

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
  imagePreview.classList.remove('d-none');
  if (event.target.files && event.target.files[0]) {
    var reader = new FileReader();

    reader.readAsDataURL(event.target.files[0])

    reader.onload = function (e) {
      console.log(e.target.result)
      // imagePreview.src = e.target.result;
      imagePreview.insertAdjacentHTML('afterbegin', `<img id="img_prev" width=300 height=300 src=${e.target.result} alt="Project Image" class="img-thumbnail"/>`);
    }
  }
  console.log(event.target);
};


function previewImages() {
  if (imagePreview) {
    document.getElementById('picture-upload').addEventListener('change', insertPictures)
  }
};

export { previewImages };

// <img id="img_prev" width=300 height=300 src="#" alt="your image" class="img-thumbnail d-none"/> <br/>
