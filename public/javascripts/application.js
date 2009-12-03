jQuery.ajaxSetup({ 
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

jQuery.fn.submitWithAjax = function() {
	this.submit(function() {
		$.post(this.action, $(this).serialize(), null, "script");
		return false;
	})
	return this;
};

$(document).ready(function() {
	
	$(".ajaxForm").submitWithAjax();
	
	$("#prayer_prayer").charCounter(1200);
	$("#comment_comment").charCounter(400);
	$("textarea").elastic();
	
	$('textarea.edit_prayer').keyup(function(){
		$('div.prayer div.item').html(nl2br($(this).val(), true));
	});
	
	// Create pagination
	var page = 1;
	
	$("#pagination a.more").live('click', function(){
		page++;
		$("#pagination").remove();
		$.getScript($(this).attr('href') + '?page=' + page);
		
		return false;
	});
	
	$(document).cheatCode({
		unbind : false,
		message : 'Up,Down,Left,Right',
		activated : function(){
			$('body').css('background-color', '#FFD700');
		}
	});
});

function nl2br(str, is_xhtml) {
    // Converts newlines to HTML line breaks  
    // 
    // version: 911.1619
    // discuss at: http://phpjs.org/functions/nl2br
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Philip Peterson
    // +   improved by: Onno Marsman
    // +   improved by: Atli Þór
    // +   bugfixed by: Onno Marsman
    // +      input by: Brett Zamir (http://brett-zamir.me)
    // +   bugfixed by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +   improved by: Brett Zamir (http://brett-zamir.me)
    // +   improved by: Maximusya
    // *     example 1: nl2br('Kevin\nvan\nZonneveld');
    // *     returns 1: 'Kevin<br />\nvan<br />\nZonneveld'
    // *     example 2: nl2br("\nOne\nTwo\n\nThree\n", false);
    // *     returns 2: '<br>\nOne<br>\nTwo<br>\n<br>\nThree<br>\n'
    // *     example 3: nl2br("\nOne\nTwo\n\nThree\n", true);
    // *     returns 3: '<br />\nOne<br />\nTwo<br />\n<br />\nThree<br />\n'
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';

    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ breakTag +'$2');
}