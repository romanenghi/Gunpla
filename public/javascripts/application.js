// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(document).ready(function() {
	$("div#tabs").tabs();
});
$(function() {
	$('.thumb').click(function() {
		$( "#dialog" ).dialog();
	});
});
jQuery(function() {
	jQuery('#cropbox').Jcrop({
		onChange : showCoords,
		onSelect : showCoords
	});
});
function showCoords(c) {
	$('#x').val(c.x);
	$('#y').val(c.y);
	$('#x2').val(c.x2);
	$('#y2').val(c.y2);
	$('#w').val(c.w);
	$('#h').val(c.h);
};