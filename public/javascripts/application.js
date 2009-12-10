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

jQuery.fn.enhanceAvatar = function() {
	return this.each(function(){
		$(this).click(onClick);
	});
	
	function onClick()
	{
		$(this).fadeOut('fast', function(){
			var original = $(this).children().attr('src');
			var large = $(this).attr('href');
			$(this).children().attr('src', large);
			$(this).attr('href', original);
			$(this).children().toggleClass('large_avatar');
			$(this).fadeIn();
		});
		return false;
	}
}

$(document).ready(function() {
	
	$(".ajaxForm").submitWithAjax();
	$("#prayer_prayer").charCounter(1200);
	$("#comment_comment").charCounter(400);
	$("textarea").elastic();
	$("a.expand_avatar").enhanceAvatar();
	
	$('textarea.edit_prayer').keyup(function(){
		$('div.prayer div.item').html(nl2br($(this).val(), true));
	});
	
	$('#search').focus(function(){
		if($(this).val() == 'Search')
		{
			$(this).val('');
		}
	});
	
	// Commiting to praying
	$(".i_am_praying").live('click', function(){
		$.getScript($(this).attr('href'));
		return false;
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
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br />' : '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1'+ breakTag +'$2');
}