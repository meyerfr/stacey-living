import { addEventListenerToAmenityField } from 'selectAmenity';

var createAmenitiesModal = document.getElementById("createAmenitiesModal")

if (createAmenitiesModal) {
  $("#createAmenitiesModal").on("hide.bs.modal", function(e) {
    $("#new_amenity").trigger("reset");
    document.getElementById("new_amenity").querySelector("input[type='submit']").disabled = false;
  });
}

function addAmenity() {
  var amenityForm  = document.getElementById('new_amenity');
  if (amenityForm) {
    amenityForm.addEventListener('submit', function(e) {
      e.preventDefault();
      const file = e.target.amenity_photo.files[0]
      const name = e.target.amenity_name.value
      const title = e.target.amenity_title.value

      const formData = new FormData()
      // formData.append('amenity', {})
      //append the file directly to formData. It's read in automatically
      formData.append('photo', file)
      formData.append('name', name)
      formData.append('title', title)

      fetch(`http://localhost:3000${$(this).attr('action')}`, {
        method: 'POST',
        headers: {
          'Accept': 'application/json'
        },
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        data['photo'] = file;
        insertNewAmenity(data);
        $('#createAmenitiesModal').modal('toggle');
      })

    })
  }
};


function insertNewAmenity(input, callback) {
  console.log(input)
  var all_amenities_list_wrapper = document.querySelectorAll('.project-amenities-wrapper');
  all_amenities_list_wrapper.forEach((list_wrapper) => {
    if (input.photo) {
      var reader = new FileReader();
      var amenities_index = list_wrapper.children.length;
      var amenities_name = `project[project_amenities_attributes][${amenities_index}][amenity_id]`;
      var amenities_id = `project_amenities_attributes_${amenities_index}_amenity_id`;

      reader.onload = function(e) {
        var amenity = `<div class="project-amenity-select selected">
          <input value="0" class="hidden" type="hidden" name="project[project_amenities_attributes][${amenities_index}][_destroy]" id="project_project_amenities_attributes_${amenities_index}__destroy">
          <input class=" is-valid hidden" type="hidden" value="" name="project[project_amenities_attributes][${amenities_index}][id]" id="project_project_amenities_attributes_${amenities_index}_id">
          <input class=" is-valid hidden" type="hidden" value="${input.id}" name="project[project_amenities_attributes][${amenities_index}][amenity_id]" id="project_project_amenities_attributes_${amenities_index}_amenity_id">
          <img width=20 height=20 src=${e.target.result} alt="Amenity Image"/>
          ${input.title}
        </div>`
        const insertedAmenityField = list_wrapper.insertAdjacentHTML("beforeend", amenity);
        addEventListenerToAmenityField(insertedAmenityField);
      }
      reader.readAsDataURL(input.photo); // convert to base64 string
    }
  })
}

export { addAmenity };
