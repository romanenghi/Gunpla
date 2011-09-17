// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function() {
	$("div#tabs").tabs();

	$("select").change(function() {
		var suggerimento = "Gundam " + $("#gunpla_gunplascala_id option:selected").text() + " " + $("#gunpla_gunplamodeltype_id option:selected").text();
		$("#suggerimento").html(suggerimento);
	});
	var suggerimento = "Gundam " + $("#gunpla_gunplascala_id option:selected").text() + " " + $("#gunpla_gunplamodeltype_id option:selected").text();
	$("#suggerimento").html(suggerimento);

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