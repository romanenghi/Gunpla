// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
$('.hlj').bind('ajax:beforeSend', function(){
        $(this).html('<img src="images/loading.gif" />');
		})
});

