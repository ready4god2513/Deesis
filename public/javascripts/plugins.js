/**
 *
 * Copyright (c) 2007 Tom Deater (http://www.tomdeater.com)
 * Licensed under the MIT License:
 * http://www.opensource.org/licenses/mit-license.php
 * 
 */
 
(function($) {
	/**
	 * attaches a character counter to each textarea element in the jQuery object
	 * usage: $("#myTextArea").charCounter(max, settings);
	 */
	
	$.fn.charCounter = function (max, settings) {
		max = max || 100;
		settings = $.extend({
			container: "<span></span>",
			classname: "charcounter",
			format: "(%1 characters remaining)",
			pulse: true,
			delay: 0
		}, settings);
		var p, timeout;
		
		function count(el, container) {
			el = $(el);
			if (el.val().length > max) {
			    el.val(el.val().substring(0, max));
			    if (settings.pulse && !p) {
			    	pulse(container, true);
			    };
			};
			if (settings.delay > 0) {
				if (timeout) {
					window.clearTimeout(timeout);
				}
				timeout = window.setTimeout(function () {
					container.html(settings.format.replace(/%1/, (max - el.val().length)));
				}, settings.delay);
			} else {
				container.html(settings.format.replace(/%1/, (max - el.val().length)));
			}
		};
		
		function pulse(el, again) {
			if (p) {
				window.clearTimeout(p);
				p = null;
			};
			el.animate({ opacity: 0.1 }, 100, function () {
				$(this).animate({ opacity: 1.0 }, 100);
			});
			if (again) {
				p = window.setTimeout(function () { pulse(el) }, 200);
			};
		};
		
		return this.each(function () {
			var container = (!settings.container.match(/^<.+>$/)) 
				? $(settings.container) 
				: $(settings.container)
					.insertAfter(this)
					.addClass(settings.classname);
			$(this)
				.bind("keydown", function () { count(this, container); })
				.bind("keypress", function () { count(this, container); })
				.bind("keyup", function () { count(this, container); })
				.bind("focus", function () { count(this, container); })
				.bind("mouseover", function () { count(this, container); })
				.bind("mouseout", function () { count(this, container); })
				.bind("paste", function () { 
					var me = this;
					setTimeout(function () { count(me, container); }, 10);
				});
			if (this.addEventListener) {
				this.addEventListener('input', function () { count(this, container); }, false);
			};
			count(this, container);
		});
	};

})(jQuery);

/*
 * jQuery autoResize (textarea auto-resizer)
 * @copyright James Padolsey http://james.padolsey.com
 * @version 1.04
 */

(function(jQuery){jQuery.fn.extend({elastic:function(){var mimics=['paddingTop','paddingRight','paddingBottom','paddingLeft','fontSize','lineHeight','fontFamily','width','fontWeight'];return this.each(function(){if(this.type!='textarea'){return false}var $textarea=jQuery(this),$twin=jQuery('<div />').css({'position':'absolute','display':'none','word-wrap':'break-word'}),lineHeight=parseInt($textarea.css('line-height'),10)||parseInt($textarea.css('font-size'),'10'),minheight=parseInt($textarea.css('height'),10)||lineHeight*3,maxheight=parseInt($textarea.css('max-height'),10)||Number.MAX_VALUE,goalheight=0,i=0;if(maxheight<0){maxheight=Number.MAX_VALUE}$twin.appendTo($textarea.parent());var i=mimics.length;while(i--){$twin.css(mimics[i].toString(),$textarea.css(mimics[i].toString()))}function setHeightAndOverflow(height,overflow){curratedHeight=Math.floor(parseInt(height,10));if($textarea.height()!=curratedHeight){$textarea.css({'height':curratedHeight+'px','overflow':overflow})}}function update(){var textareaContent=$textarea.val().replace(/&/g,'&amp;').replace(/  /g,'&nbsp;').replace(/<|>/g,'&gt;').replace(/\n/g,'<br />');var twinContent=$twin.html();if(textareaContent+'&nbsp;'!=twinContent){$twin.html(textareaContent+'&nbsp;');if(Math.abs($twin.height()+lineHeight-$textarea.height())>3){var goalheight=$twin.height()+lineHeight;if(goalheight>=maxheight){setHeightAndOverflow(maxheight,'auto')}else if(goalheight<=minheight){setHeightAndOverflow(minheight,'hidden')}else{setHeightAndOverflow(goalheight,'hidden')}}}}$textarea.css({'overflow':'hidden'});$textarea.keyup(function(){update()});$textarea.live('input paste',function(e){setTimeout(update,250)});update()})}})})(jQuery);
/**
 *  jQuery Plugin highlightFade (jquery.offput.ca/highlightFade)
 *  (c) 2006 Blair Mitchelmore (offput.ca) blair@offput.ca
 */
/**
 * This is version 0.7 of my highlightFade plugin. It follows the yellow fade technique of Web 2.0 fame
 * but expands it to allow any starting colour and allows you to specify the end colour as well.
 *
 * For the moment, I'm done with this plug-in. Unless I come upon a really cool feature it should have
 * this plug-in will only receive updates to ensure future compatibility with jQuery.
 *
 * As of now (Aug. 16, 2006) the plugin has been written with the 1.0.1 release of jQuery (rev 249) which
 * is available from http://jquery.com/src/jquery-1.0.1.js
 *
 * A note regarding rgb() syntax: I noticed that most browsers implement rgb syntax as either an integer 
 * (0-255) or percentage (0-100%) value for each field, that is, rgb(i/p,i/p,i/p); however, the W3C 
 * standard clearly defines it as "either three integer values or three percentage values" [http://www.w3.org/TR/CSS21/syndata.html] 
 * which I choose to follow despite the error redundancy of the typical behaviour browsers employ.
 *
 * Changelog:
 *
 *    0.7:
 *        - Added the awesome custom attribute support written by George Adamson (slightly modified)
 *        - Removed bgColor plugin dependency seeing as attr is customizable now...
 *    0.6:
 *        - Abstracted getBGColor into its own plugin with optional test and data retrieval functions
 *        - Converted all $ references to jQuery references as John's code seems to be shifting away
 *          from that and I don't want to have to update this for a long time.
 *    0.5:
 *        - Added simple argument syntax for only specifying start colour of event
 *        - Removed old style argument syntax
 *        - Added 'interval', 'final, and 'end' properties
 *        - Renamed 'color' property to 'start'
 *        - Added second argument to $.highlightFade.getBGColor to bypass the e.highlighting check
 *    0.4:
 *        - Added rgb(%,%,%) color syntax
 *    0.3:
 *        - Fixed bug when event was called while parent was also running event corrupting the
 *          the background colour of the child
 *    0.2:
 *        - Fixed bug where an unspecified onComplete function made the page throw continuous errors
 *        - Fixed bug where multiple events on the same element would speed each subsequent event
 *    0.1:
 *        - Initial Release
 * 
 * @author          Blair Mitchelmore (blair@offput.ca)
 * @version         0.5
 */
jQuery.fn.highlightFade = function(settings) {
	var o = (settings && settings.constructor == String) ? {start: settings} : settings || {};
	var d = jQuery.highlightFade.defaults;
	var i = o['interval'] || d['interval'];
	var a = o['attr'] || d['attr'];
	var ts = {
		'linear': function(s,e,t,c) { return parseInt(s+(c/t)*(e-s)); },
		'sinusoidal': function(s,e,t,c) { return parseInt(s+Math.sin(((c/t)*90)*(Math.PI/180))*(e-s)); },
		'exponential': function(s,e,t,c) { return parseInt(s+(Math.pow(c/t,2))*(e-s)); }
	};
	var t = (o['iterator'] && o['iterator'].constructor == Function) ? o['iterator'] : ts[o['iterator']] || ts[d['iterator']] || ts['linear'];
	if (d['iterator'] && d['iterator'].constructor == Function) t = d['iterator'];
	return this.each(function() {
		if (!this.highlighting) this.highlighting = {};
		var e = (this.highlighting[a]) ? this.highlighting[a].end : jQuery.highlightFade.getBaseValue(this,a) || [255,255,255];
		var c = jQuery.highlightFade.getRGB(o['start'] || o['colour'] || o['color'] || d['start'] || [255,255,128]);
		var s = jQuery.speed(o['speed'] || d['speed']);
		var r = o['final'] || (this.highlighting[a] && this.highlighting[a].orig) ? this.highlighting[a].orig : jQuery.curCSS(this,a);
		if (o['end'] || d['end']) r = jQuery.highlightFade.asRGBString(e = jQuery.highlightFade.getRGB(o['end'] || d['end']));
		if (typeof o['final'] != 'undefined') r = o['final'];
		if (this.highlighting[a] && this.highlighting[a].timer) window.clearInterval(this.highlighting[a].timer);
		this.highlighting[a] = { steps: ((s.duration) / i), interval: i, currentStep: 0, start: c, end: e, orig: r, attr: a };
		jQuery.highlightFade(this,a,o['complete'],t);
	});
};

jQuery.highlightFade = function(e,a,o,t) {
	e.highlighting[a].timer = window.setInterval(function() { 
		var newR = t(e.highlighting[a].start[0],e.highlighting[a].end[0],e.highlighting[a].steps,e.highlighting[a].currentStep);
		var newG = t(e.highlighting[a].start[1],e.highlighting[a].end[1],e.highlighting[a].steps,e.highlighting[a].currentStep);
		var newB = t(e.highlighting[a].start[2],e.highlighting[a].end[2],e.highlighting[a].steps,e.highlighting[a].currentStep);
		jQuery(e).css(a,jQuery.highlightFade.asRGBString([newR,newG,newB]));
		if (e.highlighting[a].currentStep++ >= e.highlighting[a].steps) {
			jQuery(e).css(a,e.highlighting[a].orig || '');
			window.clearInterval(e.highlighting[a].timer);
			e.highlighting[a] = null;
			if (o && o.constructor == Function) o.call(e);
		}
	},e.highlighting[a].interval);
};

jQuery.highlightFade.defaults = {
	start: [255,255,128],
	interval: 50,
	speed: 400,
	attr: 'backgroundColor'
};

jQuery.highlightFade.getRGB = function(c,d) {
	var result;
	if (c && c.constructor == Array && c.length == 3) return c;
	if (result = /rgb\(\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*,\s*([0-9]{1,3})\s*\)/.exec(c))
		return [parseInt(result[1]),parseInt(result[2]),parseInt(result[3])];
	else if (result = /rgb\(\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*,\s*([0-9]+(?:\.[0-9]+)?)\%\s*\)/.exec(c))
		return [parseFloat(result[1])*2.55,parseFloat(result[2])*2.55,parseFloat(result[3])*2.55];
	else if (result = /#([a-fA-F0-9]{2})([a-fA-F0-9]{2})([a-fA-F0-9]{2})/.exec(c))
		return [parseInt("0x" + result[1]),parseInt("0x" + result[2]),parseInt("0x" + result[3])];
	else if (result = /#([a-fA-F0-9])([a-fA-F0-9])([a-fA-F0-9])/.exec(c))
		return [parseInt("0x"+ result[1] + result[1]),parseInt("0x" + result[2] + result[2]),parseInt("0x" + result[3] + result[3])];
	else
		return jQuery.highlightFade.checkColorName(c) || d || null;
};

jQuery.highlightFade.asRGBString = function(a) {
	return "rgb(" + a.join(",") + ")";
};

jQuery.highlightFade.getBaseValue = function(e,a,b) {
	var s, t;
	b = b || false;
	t = a = a || jQuery.highlightFade.defaults['attr'];
	do {
		s = jQuery(e).css(t || 'backgroundColor');
		if ((s  != '' && s != 'transparent') || (e.tagName.toLowerCase() == "body") || (!b && e.highlighting && e.highlighting[a] && e.highlighting[a].end)) break; 
		t = false;
	} while (e = e.parentNode);
	if (!b && e.highlighting && e.highlighting[a] && e.highlighting[a].end) s = e.highlighting[a].end;
	if (s == undefined || s == '' || s == 'transparent') s = [255,255,255];
	return jQuery.highlightFade.getRGB(s);
};

jQuery.highlightFade.checkColorName = function(c) {
	if (!c) return null;
	switch(c.replace(/^\s*|\s*$/g,'').toLowerCase()) {
		case 'aqua': return [0,255,255];
		case 'black': return [0,0,0];
		case 'blue': return [0,0,255];
		case 'fuchsia': return [255,0,255];
		case 'gray': return [128,128,128];
		case 'green': return [0,128,0];
		case 'lime': return [0,255,0];
		case 'maroon': return [128,0,0];
		case 'navy': return [0,0,128];
		case 'olive': return [128,128,0];
		case 'purple': return [128,0,128];
		case 'red': return [255,0,0];
		case 'silver': return [192,192,192];
		case 'teal': return [0,128,128];
		case 'white': return [255,255,255];
		case 'yellow': return [255,255,0];
	}
};

/**
* Cheat Code: a jQuery Plugin
* @author: Trevor Morris (trovster)
* @url: http://www.trovster.com/lab/code/plugins/jquery.cheat-code.js
* @documentation: http://www.trovster.com/lab/plugins/cheat-code/
* @published: 10/05/2009
* @updated: 10/05/2009
* @license Creative Commons Attribution Non-Commercial Share Alike 3.0 Licence
*		   http://creativecommons.org/licenses/by-nc-sa/3.0/
*/
if(typeof jQuery != 'undefined') {
	jQuery(function($) {
		$.fn.extend({
			cheatCode: function(options) {
				var $$	= $(this),
					s	= $.extend({}, $.fn.cheatCode.defaults, options),
					o 	= $.metadata ? $.extend({}, s, $$.metadata()) : s,
					k	= [];
				
				return this.each(
					function() {
						$$.bind('keydown.cheatCode' + o.code.toString(), function(e){
							k.push(e.keyCode);
							if(k.toString().indexOf(o.code) >= 0){
								k = [];
								o.activated.call(this, o);
								unbind.call(this, o);
							}
						});
					}
				);
			}
		});
		
		complete = function(o){
			var $overlay = $('<div class="overlay"></div>')
				$message = $('<div class="modal"></div>');
			
			$message.text(o.message).appendTo('body');
			$overlay.appendTo('body');
			setTimeout(function(){
				$message.fadeOut(500, function(){
					$(this).remove();
					$overlay.fadeOut(500, function(){
						$(this).remove();
					});
				});
			}, 1000);
		};
		
		unbind = function(o){
			if(o.unbind===true) {
				$(this).unbind('keydown.cheatCode' + o.code.toString());
			}
		};
		
		$.fn.cheatCode.defaults = {
			'code' 		: '38,38,40,40,37,39,37,39,66,65',
			'unbind'	: true,
			'activated'	: complete,
			'message'	: 'Cheat Code Activated'
		};
	});
}