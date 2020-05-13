var createAmenitiesModal = document.getElementById("createAmenitiesModal")

if (createAmenitiesModal) {
  $("#createAmenitiesModal").on("hide.bs.modal", function(e) {
    // if (selectizeCallback != null) {
    //   selectizeCallback();
    //   selecitzeCallback = null;
    // }
    console.log('modal hide')

    $("#new_amenity").trigger("reset");
    document.getElementById("new_amenity").querySelector("input[type='submit']").disabled = false;

    // $.rails.enableFormElements($("#new_amenity"));
  });
}

function addAmenity() {
  var amenityForm  = document.getElementById('new_amenity')
  if (amenityForm) {
    amenityForm.addEventListener('submit', function(e) {
      e.preventDefault();
      $.ajax({
        method: "POST",
        url: $(this).attr("action"),
        data: $(this).serialize(),
        success: function(response) {
          console.log(response);
          insertNewAmenity(response);
          // selectizeCallback({value: response.id, text: response.name});
          // selectizeCallback = null;

          $("#createAmenitiesModal").modal('toggle');
        }
      });
    })
  }
};

function insertNewAmenity(input, callback) {
  var amenities_list_wrapper = document.querySelector('.project-amenities-wrapper');
  var amenities_index = amenities_list_wrapper.children.length;
  var amenities_name = `project[project_amenities_attributes][${amenities_index}][amenity_id]`;
  var amenities_id = `project_amenities_attributes_${amenities_index}_amenity_id`;
  var amenity = `<div class="project-amenity-select selected">
    <input value="0" class="hidden" type="hidden" name="project[project_amenities_attributes][${amenities_index}][_destroy]" id="project_project_amenities_attributes_${amenities_index}__destroy">
    <input class=" is-valid hidden" type="hidden" value="" name="project[project_amenities_attributes][${amenities_index}][id]" id="project_project_amenities_attributes_${amenities_index}_id">
    <input class=" is-valid hidden" type="hidden" value="${input.id}" name="project[project_amenities_attributes][${amenities_index}][amenity_id]" id="project_project_amenities_attributes_${amenities_index}_amenity_id">
    ${input.title}
  </div>`
  amenities_list_wrapper.insertAdjacentHTML("beforeend", amenity);
}

export { addAmenity };

// $(document).on("turbolinks:load", function() {
//   var selectizeCallback = null;

//   $(".category-modal").on("hide.bs.modal", function(e) {
//     if (selectizeCallback != null) {
//       selectizeCallback();
//       selecitzeCallback = null;
//     }

//     $("#new_category").trigger("reset");
//     $.rails.enableFormElements($("#new_category"));
//   });

//   $("#new_category").on("submit", function(e) {
//     e.preventDefault();
//     $.ajax({
//       method: "POST",
//       url: $(this).attr("action"),
//       data: $(this).serialize(),
//       success: function(response) {
//         selectizeCallback({value: response.id, text: response.name});
//         selectizeCallback = null;

//         $(".category-modal").modal('toggle');
//       }
//     });
//   });

//   $(".selectize").selectize({
//     create: function(input, callback) {
//       selectizeCallback = callback;

//       $(".category-modal").modal();
//       $("#category_name").val(input);
//     }
//   });
// });
