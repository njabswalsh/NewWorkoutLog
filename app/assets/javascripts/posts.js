$(document).on("click", ".choose-exercise", function (e) {
	var exercise_id = $(this)[0].id;
	var exercise_name = $(this)[0].text;
	
  	$("#exercise_exercise_name").val(exercise_name);
  	$("#place_exercise").text(exercise_name);
});

$(document).on('click', '.number-spinner button', function (e) {
	e.preventDefault();

	var btn = $(this),
		textVal = btn.closest('.number-spinner').find('input').val().trim(),
		newVal = 0;

	oldValue = parseInt(textVal);
	if (isNaN(oldValue)) {
		oldValue = 0;
	}

	var incrementer = 1;
	if (btn.hasClass("weight")) {
		incrementer = 5;
	}

	if (btn.attr('data-dir') == 'up') {
		newVal = oldValue + incrementer;
	} else {
		newVal = oldValue - incrementer;
	}

	if (newVal == 0 || (newVal < 0 && !btn.hasClass("weight"))) {
		newVal = ""
	}

	btn.closest('.number-spinner').find('input').val(newVal);
});


$(document).on('click', '#everyone-box', function(e) {
	$(this).parent().siblings(".check-label").addClass("isSelected");
	$(this).parent().siblings(".check-label").children().prop("checked", true);
	/* Deselect "Only Me" box*/
	$(this).parent().siblings().children("#me-box").parent().removeClass("isSelected");
	$(this).parent().siblings().children("#me-box").prop("checked", false);
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

$(document).on('click', '#me-box', function(e) {
	$(this).parent().siblings(".check-label").removeClass("isSelected");
	$(this).parent().siblings(".check-label").children().prop("checked", false);
});

$(document).on('click', '#visibility-button', function(e) {

});

$(document).on('click', '#visibility-done', function(e) {
	var text = "";
	if ($('#everyone-box').parent().hasClass("isSelected")) {
		text = "Everyone"
	} else {
		$('#everyone-box').parent().siblings().each( function () {
			if ($(this).hasClass("isSelected")){
				if (!text == "") {
					text += ", ";
				}
				text += $(this).text().trim();
			}
        });
	}
	$('#visibility-button').text("Visibility: " + text);
});


$(document).on('input', '#search-box', function(e){
	var search_val = $("#search-box").val().toLowerCase()
	$('a.choose-exercise').each( function () {
		if ($(this).text().toLowerCase().indexOf(search_val) >= 0){
			$(this).parent().show();
		} else {
			$(this).parent().hide();
		}
    });
    // Change the text displayed in the new exercise box
    var cache_children = $('#new_exercise_link').children();
    var default_link_text =  "New Exercise: "
    var link_text = default_link_text + $("#search-box").val();
    $('#new_exercise_link').text(link_text).prepend(cache_children);
    // Change the hidden form value
    $('#hidden_etype_name').val($("#search-box").val());
    // Hide the new exercise button if there is no text
    if ($("#search-box").val() == "") {
    	$("#new_exercise_link").parent().hide()
    } else {
    	$("#new_exercise_link").parent().show()
    }
});

$(document).on('click', '#add_note_button', function(e){
	if ($("#note_entry").val() == "") {
		e.preventDefault();
	}
});


$(document).on('click', '.add-exercise-entry', function(){
	$("#add_edit_exercise").text("Add Exercise");
	$("#exercise-form").attr('action', '/exercises/create');
	$(".sets-input").val("");
	$(".reps-input").val("");
	$(".weight-input").val("");
});

$(document).on('click', '.exercise-name', function(){
	exercise_name = $(this).text();
	$("#place_exercise").text(exercise_name);
	$("#exercise_exercise_name").val(exercise_name);
});

$(document).on('click', '.edit-exercise-entry', function(){
	exercise_id = parseInt($(this)[0].id.substr(9));
	exercise_name = $(this).attr('e-name');

	var sets = $(this).attr('e-sets');
	var reps = $(this).attr('e-reps');
	var weight = $(this).attr('e-weight');

	$(".sets-input").attr('value', sets);
	$(".reps-input").attr('value', reps);
	$(".weight-input").attr('value', weight);
		

	$("#place_exercise").text(exercise_name);
	$("#add_edit_exercise").text("Save Exercise");

	var action = '/exercises/update?exercise_id=' + exercise_id;
	$("#exercise-form").attr('action', action);
});

$(document).on('click', '#new_exercise_link', function(e){
	if (!$("#search-box").val() == "") {
		var valuesToSubmit = $('#new_exercise_form').serialize();
	    $.ajax({
	        type: "POST",
	        url: $('#new_exercise_form').attr('action'),
	        data: valuesToSubmit,
	        dataType: "JSON"
	    }).success(function(json){
	        if (json["status"] == "created"){
	        	var name = json["name"];
	        	var first_holder = $('.et_holder')[0];
	        	var newThumbnail = $(first_holder).clone();
	        	var close_button = $('<button type="button" class="close delete_et" id="'+json["id"]  +'" style="position: absolute; top: 20px; right: 20px;">&times;</button>')
	        	$(newThumbnail).children('.choose-exercise').text(name);
	        	$(newThumbnail).children('.choose-exercise').attr("id", name.toLowerCase());
	        	$(newThumbnail).prependTo($('#new_exercise_form').parent());
	        	$(newThumbnail).append($(close_button));
	        	$(newThumbnail).show();
	        } else {
	        	// Fail gracefully?
	        }
	    });
	}
});

$(document).on('click', '.delete_et', function(e){
	$(this).parent().remove();
	$.ajax({
	        type: "POST",
	        url: "/exercise_types/" + $(this).attr("id"),
	        data: {"_method":"delete"},
	        dataType: "JSON"
	}).success(function(json){
		//console.log("Status: ", json)
	});
});