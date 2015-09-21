// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//

$('.questionnaire-container .answerInput').on('click', function(e) {
  var questionnaireContainer = $('.questionnaire-container');
  var userId = questionnaireContainer.find('.userId')[0].value;
  var currentIndex = e.target.className.replace('answerInput answer', '');
  var questionId = questionnaireContainer.find('.questionId')[0].value;
  var userType = questionnaireContainer.find('.userType')[0].value;
  var answer = e.target.value;

  var request = $.ajax({
    method: "POST",
    url: '/users/' + userId + '/answers',
    data: {
      answer: {
        user_id: userId,
        user_type: userType,
        question_id: questionId,
        answer: answer
      }
    }
  })
  request.done(function(msg) {
    console.log(msg)
  })
});
