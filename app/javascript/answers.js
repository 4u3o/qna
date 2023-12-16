$(document).on('turbolinks:load', function(){
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault();
    $(this).toggleClass('invisible');
    var answerId = $(this).data('answerId');
    console.log(answerId);
    $('form#edit-answer-' + answerId).toggleClass('invisible');
  })
});
