$(document).on('turbolinks:load', function(){
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();

    $(this).toggleClass('hidden');

    const answerId = $(this).data('answerId');
    $('form#edit-answer-' + answerId).toggleClass('hidden');
  })
});
