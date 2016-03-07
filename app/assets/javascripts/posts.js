$(document).on("click", ".choose-exercise", function (e) {
	var exercise_id = $(this)[0].id;
	var exercise_name = $(this)[0].text;
	
  	$("#exercise_exercise_name").val(exercise_name);
  	$("#place_exercise").text(exercise_name);
});

$(document).on('click', '.number-spinner button', function (e) {
	e.preventDefault();

	var btn = $(this),
		oldValue = btn.closest('.number-spinner').find('input').val().trim(),
		newVal = 0;

	var incrementer = 1;
	if (btn.hasClass("weight")) {
		incrementer = 5;
	}


	if (btn.attr('data-dir') == 'up') {
		newVal = Math.max(parseInt(oldValue) + incrementer, 1);
	} else {
		newVal = Math.max(parseInt(oldValue) - incrementer, 1);
	}
	if (isNaN(newVal)){
		newVal = 1;
	}
	btn.closest('.number-spinner').find('input').val(newVal);
});