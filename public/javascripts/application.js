// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  // Handler for .ready() called.
  $(".hlj").click(function () { $('#datahlj').load(this.href); 
	});
});