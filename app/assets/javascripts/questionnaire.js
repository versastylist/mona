$('.questionnaire-container .answerInput').on('click', function(e) {
  var questionnaireContainer = $('.questionnaire-container');
  var userId = questionnaireContainer.find('.userId')[0].value;
  var currentIndex = e.target.className.replace('answerInput answer', '');
  var questionId = questionnaireContainer.find('.questionId')[currentIndex].value;
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
  request.done(function(data) {
    if (data.questionnaireComplete) {
      $('#completeRegistrationButton').show()
    }
  })
});
