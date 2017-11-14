$(document).ready(function() {
  $(".get-car-form").on('click', (e) => {
    e.preventDefault();
    const url = $(e.currentTarget).attr('href');
    $.ajax({
      url,
    }).done((response) => {
      $(".car-form-container").append(response);
    });

    $(".car-form-container").on('submit', '.new-car-form', (e) => {
      e.preventDefault();
      console.log("Hopefully this works!");
    });
  });
});
