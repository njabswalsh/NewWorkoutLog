$(document).ready(function() {
	if ($('#error-exists')){
    	$('.form-group').each(function() {
	    	$(this).addClass('has-error');
		});
	}

});