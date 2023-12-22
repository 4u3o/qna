$(document).on('turbolinks:load', function() {
  $('.edit-question-link').on('click', (e) => {
    e.preventDefault();

    $('.edit-question-link').toggleClass('hidden');
    $('.question').toggleClass('hidden');
    $('.edit-question-form').toggleClass('hidden');
  });
});
