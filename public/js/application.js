$(document).ready(function() {

  $(".get-car-form").on('click', (e) => {
    const _this = this;
    debugger;
    e.preventDefault();
    const url = $(e.currentTarget).attr('href');
    $.ajax({
      url,
      cache: false,
      success: (response) =>{
        $(".car-form-container").append(response);
        $(_this).hide();
      });

    $(".car-form-container").on('submit', '.new-car-form', (e) => {
      e.preventDefault();

      const $form = $(e.currentTarget);
      const url = $form.attr("action");
      const data = $form.serialize();

      debugger;
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
