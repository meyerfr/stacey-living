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
};

function insertNewAmenity(input, callback) {
  var amenities_list_wrapper = document.querySelector('.project-amenities');
  var amenities_index = amenities_list_wrapper.children.length;
  var amenities_name = `project[project_amenities_attributes][${amenities_index}][amenity_id]`;
  var amenities_id = `project_amenities_attributes_${amenities_index}_amenity_id`;
  var amenity = `<label>
                  <input name=${amenities_name} id=${amenities_id} type="checkbox" value=${input.id}>
                  ${input.title}
                </label>`
  // const amenity = `<label><%= pa.check_box("amenity_id", { name: ${amenities_name}, id: ${amenities_id} }, amenity.id, nil) %><%= amenity.title %></label>`;
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
