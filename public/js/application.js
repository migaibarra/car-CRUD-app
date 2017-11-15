$(document).ready(function() {

  $(".get-car-form").on('click', (e) => {
    e.preventDefault();
    const url = $(e.currentTarget).attr('href');
    $.ajax({
      url,
    }).done((response) => {
      $(".car-form-container").html(response);
    });

    $(".car-form-container").on('submit', '.new-car-form', (e) => {
      e.preventDefault();

      const $form = $(e.currentTarget);
      const url = $form.attr("action");
      const data = $form.serialize();

      $.ajax({
        method: "POST",
        url,
        data,
      }).done((response) => {
        console.log(response);
        $(".car-form-container").empty();
        $(".car-list").append(response);
      });
    });

  });
});
