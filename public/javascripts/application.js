// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


jQuery(document).ready(function() {
	$("div#tabs").tabs();
});


$(document).ready(function() {
        var cont_left = $("#container").position().left;
        $("img.zoom").hover(function() {
            // hover in
            $(this).parent().parent().css("z-index", 1);
            $(this).animate({
               height: "250",
               width: "250",
               left: "-=50",
               top: "-=50"
            }, "fast");
        }, function() {
            // hover out
            $(this).parent().parent().css("z-index", 0);
            $(this).animate({
                height: "150",
                width: "150",
                left: "+=50",
               top: "+=50"
            }, "fast");
        });

        $(".img").each(function(index) {
            var left = (index * 160) + cont_left;
            $(this).css("left", left + "px");
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