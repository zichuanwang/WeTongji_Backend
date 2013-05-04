$(function(){
	
/* =============================================================================
   GENERAL
   ========================================================================== */

/* JS enabled user
   -------------------------------------------------------------------------- */
	$('html').removeClass('no-js').addClass('has-js');
	
	
/* Touch or mouse ?
   -------------------------------------------------------------------------- */
	var ua = navigator.userAgent;
    function is_touch_device() { 
        try {  
            document.createEvent("TouchEvent");  
            return true;  
        } catch (e) {  
            return false;  
        }  
    }

    if ((is_touch_device()) || ua.match(/(iPhone|iPod|iPad)/) 
    || ua.match(/BlackBerry/) || ua.match(/Android/)) {
        $('body').addClass('touch');
    } else {
        $('body').addClass('mouse');
		initCustomScroll();
    }
	
	
/* Resize dispatcher
   -------------------------------------------------------------------------- */
	$(window).on('resize', function() {
		resizeBackground();
		initSlideshow();
		iphoneSlideshowResize();
		initIscroll();
		iscrollResize();
	});
	
	
/* Image replacement on hover
   -------------------------------------------------------------------------- */
	$('body').on('hover', '.hover-img', function(e) {
		if ( !$(this).hasClass('current') ) {
			var img = $(this).find('img');
			if (img.length == 0)
				img = $(this);
			
			var src = img.attr('src');
			if (src) {
				if ( e.type == 'mouseenter' ) {
					var newSrc = src.replace(new RegExp("(\.png|\.jpg)", "i"), "_active$1");
				} else if ( e.type == 'mouseleave' ) {
					var newSrc = src.replace('_active','');
				}
				img.attr('src',newSrc);
			}
		}
	});
	
	
/* Placeholder emulation for old browser
   -------------------------------------------------------------------------- */
	var formElements = $('input:text, input:password, textarea');
	formElements.on('focus', function() {
		$('label[for='+$(this).attr('id')+']').hide();
	}).on('blur', function() {
		if ($(this).attr('value') == '' || $(this).attr('value') == $('label[for='+$(this).attr('id')+']').text()) {
			$('label[for='+$(this).attr('id')+']').show();
		}
	}).on('refresh', function() {
		if ($(this).attr('value') == '' || $(this).attr('value') == $('label[for='+$(this).attr('id')+']').text()) {
			$('label[for='+$(this).attr('id')+']').show();
		} else {
			$('label[for='+$(this).attr('id')+']').hide();
		}
	}).trigger('refresh');
	
	

/* =============================================================================
   BACKGROUND
   ========================================================================== */

/* Background resize
   -------------------------------------------------------------------------- */
	var backgroundRatio = 16/9; // 2560x1440
	
	function resizeBackground() {
		var background = $('img.page-background');
		
		if ($(window).width() > 1000) {
			background.width($(window).width());
			background.height($(window).width()/backgroundRatio);
			
			if (background.height() < $(window).height()) {
				background.height($(window).height());
				background.width($(window).height()*backgroundRatio);
			}
		} else {
			background.width(background.parent().height()*backgroundRatio);
			background.height(background.parent().height());
			if (background.height() < $(document).height()) {
				background.height($(document).height());
				background.width($(document).height()*backgroundRatio);
			}
			if (background.width() < $(window).width()) {
				background.width($(window).width());
				background.height($(window).width()/backgroundRatio);
			}
		}
	}
	resizeBackground();
	
	

/* =============================================================================
   LOADER
   ========================================================================== */

/* Site loading
   -------------------------------------------------------------------------- */
	$(window).load(function() {
		siteLoaded();
	});
	
	

/* =============================================================================
   NAV
   ========================================================================== */

/* Nav main
   -------------------------------------------------------------------------- */
	$('#nav-main a').on('click', function(e) {
		if ($(this).attr('data-target') && !$(this).closest('li').hasClass('current')) {
			var id = $(this).attr('data-target');
			
			if (pageAnimated === false) {
				changePage($(id), true);
			}
			
			e.preventDefault();
		}
	});


/* Nav top share animation
   -------------------------------------------------------------------------- */
	$('#nav-top > ul').on('hover', function(e) {
		var child = $(this).find('ul');
		var childHeight = child.height();
		
		if (e.type == 'mouseenter') {
			child.css({top:-childHeight});
			child.stop(true).animate({top:0}, {duration:300, easing:'easeInOutCubic'});
		} else {
			child.stop(true).animate({top:-childHeight}, {duration:300, easing:'easeInOutCubic', complete:function() {
				$(this).attr('style','');
			}});
		}
	});
	
	$('#nav-top .title').on('click', function(e) {
		var child = $(this).siblings('ul');
		var childHeight = child.height();
		
		if (!child.hasClass('open')) {
			child.css({top:-childHeight});
			child.stop(true).animate({top:0}, {duration:300, easing:'easeInOutCubic'});
			child.addClass('open');
		} else {
			child.stop(true).animate({top:-childHeight}, {duration:300, easing:'easeInOutCubic', complete:function() {
				$(this).attr('style','').removeClass('open');
			}});
		}
		
		e.preventDefault();
	});
	

/* Nav page
   -------------------------------------------------------------------------- */
	var pageAnimated = false;
	
	$('#nav-page a').on('click', function(e) {
		if (pageAnimated === false) {
			if($(this).hasClass('next'))
				changePage(true, true);
			else
				changePage(false, true);
		}
		
		e.preventDefault();
	})
	
	function changePage(next, animate) {
		if (pageAnimated === false) {
			pageAnimated = true;
			
			var currentPage = $('.page-current');
			var currentPageIndex = currentPage.index('.page');
			var nextPage = '';
			if (next === true) {
				nextPage = currentPage.next('.page');
			} else if (next === false) {
				nextPage = currentPage.prev('.page');
			} else {
				nextPage = next;
			}
			var nextPageIndex = nextPage.index('.page');
			
			if (nextPage.length == 1 && !nextPage.hasClass('page-current') && !nextPage.hasClass('page-text')) {
				
				var container = $('<div></div>');
				container.css({overflow:'hidden',position:'absolute', top:0, left:0, width:0, height:'100%', zIndex:2})
				
				nextPage.css({width:$(window).width()});
				container.insertAfter(nextPage);
				nextPage.appendTo(container);
				
				if (nextPageIndex > currentPageIndex) {
					container.css({right:0, left:'auto'});
					nextPage.css({right:0, left:'auto'});
				} else {
					nextPage.css({left:0});
				}
				
				var animationDuration = 1000;
				if (animate === false)
					animationDuration = 0;
				
				container.animate({width:$(window).width()}, {duration:animationDuration, easing:'easeInOutExpo', complete:function() {
					currentPage.removeClass('page-current').attr('style','');
					nextPage.addClass('page-current').attr('style','').insertAfter(container);
					container.remove();
					checkNavPage();
					pageAnimated = false;
				}});
				
				if (nextPage.is('#page-filters'))
					$('body').addClass('dark');
				else
					$('body').removeClass('dark');
			} else {
				pageAnimated = false;
			}
		}
	}
	
	function checkNavPage() {
		var currentPage = $('.page-current');
		var id = currentPage.attr('id');
		window.location.hash = '#'+id;
		
		if (currentPage.is('.page:last') || currentPage.next('.page').hasClass('page-text'))
			$('#nav-page .next').fadeOut(200, 'linear');
		else
			$('#nav-page .next').fadeIn(200, 'linear');
			
		if (currentPage.is('.page:first'))
			$('#nav-page .previous').fadeOut(200, 'linear');
		else
			$('#nav-page .previous').fadeIn(200, 'linear');
			
		$('#nav-main .current').removeClass('current');
		$('#nav-main a[data-target="#'+id+'"]').closest('li').addClass('current');
	}

/* Nav mobile
   -------------------------------------------------------------------------- */
	$('#nav-mobile .menu-link').on('click', function(e) {
		var container = $('#nav-mobile .container');
		
		$('#nav-mobile').addClass('opened');
		
		container.css({left:-$(window).width()});
		container.animate({left:0}, {duration:500, easing:'easeInOutCubic'});
		
		e.preventDefault();
	});
	
	$('#nav-mobile ul a').on('click', function(e) {
		var container = $('#nav-mobile .container');
		
		container.animate({left:-$(window).width()}, {duration:500, easing:'easeInOutCubic', complete:function() {
			$('#nav-mobile').removeClass('opened');
			$(this).attr('style','');
		}});
		
		if ($(this).attr('data-target')) {
			var id = $(this).attr('data-target');
			var page = $(id);
			
			if (pageAnimated === false && !page.hasClass('page-current')) {
				changePage($(id), false);
			}
			
			e.preventDefault();
		}
	});
	
	

/* =============================================================================
   IPHONE SLIDESHOW
   ========================================================================== */
	
	var iphoneSlideshowAnimated = false;
	
	var iphoneSlideshowDuration = 4000;
	var iphoneSlideshowTimeout = null;
	
	
/* Slideshow navigation
   -------------------------------------------------------------------------- */
	$('#iphone-slideshow .navigation').on('click', 'a', function(e) {
		var index = $(this).index();
		
		iphoneSlideshowShowSlide(index);
		
		$('#iphone-slideshow .navigation a').removeClass('current');
		$(this).addClass('current');
		
		e.preventDefault();
	});


/* Show slide at the given index
   -------------------------------------------------------------------------- */
	function iphoneSlideshowShowSlide(index) {
		if (iphoneSlideshowAnimated === false) {
			iphoneSlideshowAnimated = true;
			
			var container = $('#iphone-slideshow .screens');
			
			var currentSlide = $('#iphone-slideshow .screens .current');
			var newSlide = $('#iphone-slideshow .screen').eq(index);
			
			if (newSlide.index() > currentSlide.index()) {
				newSlide.css({left:container.width(), zIndex:3});
				newSlideLeft = 0;
				currentSlideLeft = -container.width();
			} else {
				newSlide.css({left:-container.width(), zIndex:3});
				newSlideLeft = 0;
				currentSlideLeft = container.width();
			}
			
			newSlide.animate({left:newSlideLeft}, {duration:500, easing:'easeInOutCubic'});
			currentSlide.animate({left:currentSlideLeft}, {duration:500, easing:'easeInOutCubic', complete:function() {
				currentSlide.removeClass('current').css({left:''});
				newSlide.addClass('current').css({left:''})
				iphoneSlideshowAnimated = false;
			}});
			
			
			if ($(window).width() > 1000) {
				clearTimeout(iphoneSlideshowTimeout);
				iphoneSlideshowTimeout = setTimeout(iphoneSlideshowNext, iphoneSlideshowDuration);
			}
		}
	}


/* Show next slide
   -------------------------------------------------------------------------- */
	function iphoneSlideshowNext() {
		var nextLink = $('#iphone-slideshow .navigation .current').next();
		
		if (nextLink.length == 0)
			nextLink = $('#iphone-slideshow .navigation a').first();
			
		nextLink.click();
	}


/* Show previous slide
   -------------------------------------------------------------------------- */
	function iphoneSlideshowPrev() {
		var nextLink = $('#iphone-slideshow .navigation .current').prev();
		
		if (nextLink.length == 0)
			nextLink = $('#iphone-slideshow .navigation a').last();
			
		nextLink.click();
	}
	

/* Init slideshow
   -------------------------------------------------------------------------- */
	function initSlideshow() {
		if ($(window).width() > 1000) {
			if (iphoneSlideshowTimeout === null)
				iphoneSlideshowTimeout = setTimeout(iphoneSlideshowNext, iphoneSlideshowDuration);
		} else {
			clearTimeout(iphoneSlideshowTimeout);
			iphoneSlideshowTimeout = null;
		}
	}
	initSlideshow();
	
	
/* Slideshow resize
   -------------------------------------------------------------------------- */
	function iphoneSlideshowResize() {
		var slideshow = $('#iphone-slideshow');
		var screens = $('#iphone-slideshow .screens');
		var screen = $('#iphone-slideshow .screen');
		
		if ($(window).width() <= 1000) {
			screens.attr('style', '');
			slideshow.height($(window).height());
			screen.height('').width($(window).width()*0.7);
			if (screen.first().height() > $(window).height()*0.8) {
				screen.width('').height($(window).height()*0.8);
			}
			
			screens.css({marginTop:-screen.height()/2, marginLeft:-screen.width()/2, width:screen.width(), height:screen.height()})
		} else {
			slideshow.attr('style','');
			screens.attr('style','');
			screen.attr('style','');
		}
	}
	iphoneSlideshowResize();
	
	
/* Slideshow wipe
   -------------------------------------------------------------------------- */
	$('#iphone-slideshow').wipetouch({
		wipeLeft: function(result) {
			iphoneSlideshowNext();
		},
		wipeRight: function(result) {
			iphoneSlideshowPrev();
		}
	});
	
	

/* =============================================================================
   GALLERY
   ========================================================================== */

/* Image click
   -------------------------------------------------------------------------- */
	$('#gallery a').on('click', function(e) {
		
		imagePopin($(this).find('.image'));
		
		e.preventDefault();
	});
	
	
/* Image popin
   -------------------------------------------------------------------------- */
	function imagePopin(image) {
		var newImage = image.clone();
		
		var src = newImage.attr('src');
		if (src) {
			var newSrc = src.replace('-mobile','');
			newImage.attr('src',newSrc);
		}
		
		newImage.attr('class', '').attr('style','');
		var popin = $('<div id="popin"></div>');
		newImage.appendTo(popin);
		popin.prependTo('body');
		
		var origWidth = newImage.width();
		var origHeight = newImage.height();
		
		popin.hide();
		
		var imageRatio = origWidth/origHeight;
		var newWidth = origWidth;
		var newHeight = origHeight;
		
		if ($(window).width() > 1000) {
			if (newWidth>$(window).width()-60) {
				newWidth = $(window).width()-60;
				newHeight = newWidth/imageRatio;
			}
			if (newHeight>$(window).height()-60) {
				newHeight = $(window).height()-60
				newWidth = newHeight*imageRatio;
			}
			
			var newMarginLeft = -(newWidth/2+15);
			var newMarginTop = -(newHeight/2+15);
			
		} else {
			if (newWidth>$(window).width()) {
				newWidth = $(window).width();
				newHeight = newWidth/imageRatio;
			}
			if (newHeight>$(window).height()) {
				newHeight = $(window).height();
				newWidth = newHeight*imageRatio;
			}
			
			var newMarginLeft = -(newWidth/2);
			var newMarginTop = -(newHeight/2);
		}
		
		newImage.css({marginTop:newMarginTop, marginLeft:newMarginLeft, position:'absolute', top:'50%', left:'50%', width:newWidth, height:newHeight})
		
		popin.fadeIn(300, 'linear');
		
	}

	
/* Popin close
   -------------------------------------------------------------------------- */
	$('body').on('click', '#popin', function() {
		$(this).fadeOut(300, 'linear', function() {
			$(this).remove();
		})
	});
	
	

/* =============================================================================
   PAGE TEXT
   ========================================================================== */
	
/* Page open
   -------------------------------------------------------------------------- */
	$('.page-text-link').on('click', function(e) {
		var page = $($(this).attr('data-page'));
		
		page.css({display:'none', left:0});
		page.fadeIn(500, 'linear');
		
		e.preventDefault();
	});
	
	
/* Terms close
   -------------------------------------------------------------------------- */
	$('.page-text .page-background, .page-text .back-link').on('click', function(e) {
		$(this).closest('.page-text').fadeOut(500, 'linear', function() {
			$(this).attr('style','');
		});
	});
	
	
/* Custom scroll
   -------------------------------------------------------------------------- */
	function initCustomScroll() {
		$('.page-text .page-content').mCustomScrollbar();
	}
	
	

/* =============================================================================
   ADDRESS CHANGE
   ========================================================================== */
	
	var windowHash = window.location.hash;
	var checkAddressTimeout = setInterval(checkAddress, 100);
	

/* Check address
   -------------------------------------------------------------------------- */
	function checkAddress() {
		if (window.location.hash != windowHash) {
			windowHash = window.location.hash;
			if (windowHash == '')
				windowHash = '#page-home';
			
			var id = windowHash
			var page = $(id);
			
			if (pageAnimated === false && !page.hasClass('page-current')) {
				changePage($(id), true);
			}
		}
	}
	
	

/* =============================================================================
   INIT
   ========================================================================== */

	var hash = window.location.hash;
	var firstPage = $('.page').filter(hash);
	if (firstPage.length == 1) {
		$('.page-current').removeClass('page-current');
		firstPage.addClass('page-current');
		checkNavPage();
	}
	
	
/* Init site after loading
   -------------------------------------------------------------------------- */
	function siteLoaded() {
		$('#site-loader').fadeTo(1000, 0, 'linear', function() {
			$('#page-home').addClass('loaded');
			$(this).remove();
		});
		
		$(window).trigger('resize');
	}
	

/* Init iscroll
   -------------------------------------------------------------------------- */
	var iScrolls = null;
	
	function initIscroll() {
		
		if (iScrolls != null) {
			for(var i = 0; i <= iScrolls.length; i++) {
				var temp = iScrolls[i];
				if (temp)
					temp.destroy();
			}
			$('.iscroll-barV').remove();
			$('.iscroll, .iscroll > div').attr('style','');
		}
		iScrolls = null;
		var elements = null;
		
		if ($(window).width() <= 1000) {
			elements = $('.iscroll');
			if ($(window).height() >= 600) {
				elements = elements.filter('.tablet');
			}
		} else if ($('body').hasClass('touch')) {
			elements = $('.page-text .iscroll');
		}
		
		if (elements != null && elements.length > 0) {
			iScrolls = new Array();
			elements.each(function() {
				var temp = new iScroll(this, {
					hScroll: false,
					vScroll: true,
					hScrollbar: false,
					vScrollbar: true,
					hideScrollbar: true,
					scrollbarClass: 'iscroll-bar'
				});
				
				iScrolls.push(temp);
			});
		}
	}
	initIscroll();
	

/* Iscroll resize
   -------------------------------------------------------------------------- */
	function iscrollResize() {
		var pageContent = $('.page-content');
			pageContent.width($(window).width());
	}
	iscrollResize();
	
/* RenRen Share
   -------------------------------------------------------------------------- */
});