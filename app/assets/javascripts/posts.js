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


$(document).on('click', '.select-box', function(e) {
	if ($(this).parent().hasClass("isSelected")) {
		$(this).parent().siblings().children("#everyone-box").parent().removeClass("isSelected");
		$(this).parent().siblings().children("#everyone-box").prop("checked", false);
		if (!$(this).parent().siblings(".check-label").hasClass("isSelected")) {
			$(this).parent().siblings().children("#me-box").parent().addClass("isSelected");
			$(this).parent().siblings().children("#me-box").prop("checked", true);
		}
	} else {
		$(this).parent().siblings().children("#me-box").parent().removeClass("isSelected");
		$(this).parent().siblings().children("#me-box").prop("checked", false);
	}
	if ($(this).attr("id") == "me-box") {
		$(this).parent().addClass("isSelected");
		$(this).prop("checked", true);
	} else {
		$(this).parent().toggleClass("isSelected");
	}
});

$(document).on('click', '#everyone-box', function(e) {
	$(this).parent().siblings(".check-label").addClass("isSelected");
	$(this).parent().siblings(".check-label").children().prop("checked", true);
	/* Deselect "Only Me" box*/
	$(this).parent().siblings().children("#me-box").parent().removeClass("isSelected");
	$(this).parent().siblings().children("#me-box").prop("checked", false);
});

$(document).on('click', '#me-box', function(e) {
	$(this).parent().siblings(".check-label").removeClass("isSelected");
	$(this).parent().siblings(".check-label").children().prop("checked", false);
});