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
});

$(document).on('click', '#add_note_button', function(e){
	if ($("#note_entry").val() == "") {
		e.preventDefault();
	}
});

$(document).on('click', '#new_exercise_link', function(e){
	if (!$("#search-box").val() == "") {
		var valuesToSubmit = $('#new_exercise_form').serialize();
	    $.ajax({
	        type: "POST",
	        url: $('#new_exercise_form').attr('action'), //sumbits it to the given url of the form
	        data: valuesToSubmit,
	        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
	    }).success(function(json){
	        if (json["status"] == "created"){
	        	var name = json["name"];
	        	var first_holder = $('.et_holder')[0];
	        	var newThumbnail = $(first_holder).clone();
	        	$(newThumbnail).children('.choose-exercise').text(name);
	        	$(newThumbnail).children('.choose-exercise').attr("id", name.toLowerCase());
	        	$(newThumbnail).prependTo($('#new_exercise_form').parent());
	        	$(newThumbnail).show();
	        } else {
	        	// Fail gracefully?
	        }
	    });
	}
});