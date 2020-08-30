$(document).ready(function() {

    var sync1 = $("#mainslider");
    var sync2 = $("#mainslider1");
    var slidesPerPage = 4;
    var syncedSecondary = true;

    sync1.owlCarousel({
        items: 1,
        slideSpeed: 4000,
        nav: true,
        autoplay: true,
        dots: true,
        loop: true,
        responsiveRefreshRate: 200,
        navText: ['<svg width="100%" height="100%" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>', '<svg width="100%" height="100%" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 1px;stroke: #000;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>'],
    }).on('changed.owl.carousel', syncPosition);

    sync2
        .on('initialized.owl.carousel', function() {
            sync2.find(".owl-item").eq(0).addClass("current");
        })
        .owlCarousel({
            items: slidesPerPage,
            dots: true,
            nav: true,
            smartSpeed: 1000,
            slideSpeed: 1000,
            slideBy: slidesPerPage,
            responsiveClass: true,
            responsive: {
                0: {
                    items: 2,
                    nav: true
                },
                600: {
                    items: 2,
                    nav: true
                },
                769: {
                    items: 3,
                    nav: true
                },
                992: {
                    items: 4,
                    nav: true,
                    loop: false
                }
            }
            //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel

        }).on('changed.owl.carousel', syncPosition2);

    function syncPosition(el) {
        //if you set loop to false, you have to restore this next line
        //var current = el.item.index;

        //if you disable loop you have to comment this block
        var count = el.item.count - 1;
        var current = Math.round(el.item.index - (el.item.count / 2) - .5);

        if (current < 0) {
            current = count;
        }
        if (current > count)  {
            current = 0;
        }

        //end block

        sync2
            .find(".owl-item")
            .removeClass("current")
            .eq(current)
            .addClass("current");
        var onscreen = sync2.find('.owl-item.active').length - 1;
        var start = sync2.find('.owl-item.active').first().index();
        var end = sync2.find('.owl-item.active').last().index();

        if (current > end) {
            sync2.data('owl.carousel').to(current, 100, true);
        }
        if (current < start) {
            sync2.data('owl.carousel').to(current - onscreen, 100, true);
        }
    }

    function syncPosition2(el) {
        if (syncedSecondary) {
            var number = el.item.index;
            sync1.data('owl.carousel').to(number, 100, true);
        }
    }

    sync2.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).index();
        sync1.data('owl.carousel').to(number, 300, true);
    });
});

$('.home-owl-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsiveClass: true,
    responsive: {
        0: {
            items: 1,
            nav: true
        },
        600: {
            items: 2,
            nav: true
        },
        769: {
            items: 3,
            nav: true
        },
        992: {
            items: 4,
            nav: true,
            loop: false
        }
    }
});



$('.partners-owl-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsiveClass: true,
    responsive: {
        0: {
            items: 2,
            nav: true
        },
        600: {
            items: 3,
            nav: true
        },
        769: {
            items: 4,
            nav: true
        },
        992: {
            items: 5,
            nav: true,
            loop: false
        }
    }
});

$(function() {
    $(".nav-dropdown-menu .dropdown").hover(
        function() {
            $('.nav-dropdown-menu .dropdown-menu', this).stop(true, true).fadeIn("slow");
            $(this).toggleClass('open');
            $('b', this).toggleClass("caret caret-up");
        },
        function() {
            $('.nav-dropdown-menu .dropdown-menu', this).stop(true, true).fadeOut("slow");
            $(this).toggleClass('open');
            $('b', this).toggleClass("caret caret-up");
        });
});

$('.nav-dropdown-menu .dropdown').hover(function() {
    $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
}, function() {
    $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
});


$(function() {
    var header = $("header");
    $(window).scroll(function() {
        var scroll = $(window).scrollTop();

        if (scroll >= 500) {
            header.addClass("stickyHeader2");
        } else {
            header.removeClass("stickyHeader2");
        }
    });
});

$(document).ready(function() {
    var trigger = $('.hamburger'),
        overlay = $('.overlay'),
        isClosed = false;

    trigger.click(function() {
        hamburger_cross();
    });

    function hamburger_cross() {

        if (isClosed == true) {
            overlay.hide();
            trigger.removeClass('is-open');
            trigger.addClass('is-closed');
            isClosed = false;
        } else {
            overlay.show();
            trigger.removeClass('is-closed');
            trigger.addClass('is-open');
            isClosed = true;
        }
    }

    $('[data-toggle="offcanvas"]').click(function() {
        $('.mobile-nav').toggleClass('toggled');
    });
});

$(".nav-dropdown-menu").hover(function() {
    $('.leftnavOverlay').toggleClass('show-overlay');
});


$(".dropdown-cart").hover(function() {
    $(this).toggleClass("open");
});
$(".dropdown-login").hover(function() {
    $(this).toggleClass("open");
});



$(document).ready(function() {
    // Show or hide the sticky footer button
    $(window).scroll(function() {
        if ($(this).scrollTop() > 200) {
            $('.go-top').fadeIn(200);
        } else {
            $('.go-top').fadeOut(200);
        }
    });

    // Animate the scroll to top
    $('.go-top').click(function(event) {
        event.preventDefault();

        $('html, body').animate({
            scrollTop: 0
        }, 300);
    });
});

$(document).ready(function() {

    var sync1 = $("#single-product-gallery");
    var sync2 = $("#single-product-gallery-thumbs");
    var slidesPerPage = 3;
    var syncedSecondary = true;

    sync1.owlCarousel({
        items: 1,
        slideSpeed: 4000,
        nav: false,
        autoplay: false,
        dots: false,
        loop: true,
        responsiveRefreshRate: 200,
    }).on('changed.owl.carousel', syncPosition);

    sync2
        .on('initialized.owl.carousel', function() {
            sync2.find(".owl-item").eq(0).addClass("current");
        })
        .owlCarousel({
            margin: 30,
            items: slidesPerPage,
            dots: true,
            nav: true,
            smartSpeed: 1000,
            slideSpeed: 1000,
            slideBy: slidesPerPage,
            responsiveClass: true,
            navText: ['<svg width="20px" height="20px" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 2px;stroke: #167bcb;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>', '<svg width="20px" height="20px" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 2px;stroke: #167bcb;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>'],
            responsive: {
                0: {
                    items: 3,
                    nav: true
                },
                600: {
                    items: 3,
                    nav: true
                },
                769: {
                    items: 3,
                    nav: true
                },
                992: {
                    items: 3,
                    nav: true,
                    loop: false
                }
            }
            //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel

        }).on('changed.owl.carousel', syncPosition2);

    function syncPosition(el) {
        //if you set loop to false, you have to restore this next line
        //var current = el.item.index;

        //if you disable loop you have to comment this block
        var count = el.item.count - 1;
        var current = Math.round(el.item.index - (el.item.count / 2) - .5);

        if (current < 0) {
            current = count;
        }
        if (current > count)  {
            current = 0;
        }

        //end block

        sync2
            .find(".owl-item")
            .removeClass("current")
            .eq(current)
            .addClass("current");
        var onscreen = sync2.find('.owl-item.active').length - 1;
        var start = sync2.find('.owl-item.active').first().index();
        var end = sync2.find('.owl-item.active').last().index();

        if (current > end) {
            sync2.data('owl.carousel').to(current, 100, true);
        }
        if (current < start) {
            sync2.data('owl.carousel').to(current - onscreen, 100, true);
        }
    }

    function syncPosition2(el) {
        if (syncedSecondary) {
            var number = el.item.index;
            sync1.data('owl.carousel').to(number, 100, true);
        }
    }

    sync2.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).index();
        sync1.data('owl.carousel').to(number, 300, true);
    });
});

// Starrr plugin (https://github.com/dobtco/starrr)
var __slice = [].slice;

(function($, window) {
    var Starrr;

    Starrr = (function() {
        Starrr.prototype.defaults = {
            rating: void 0,
            numStars: 5,
            change: function(e, value) {}
        };

        function Starrr($el, options) {
            var i, _, _ref,
                _this = this;

            this.options = $.extend({}, this.defaults, options);
            this.$el = $el;
            _ref = this.defaults;
            for (i in _ref) {
                _ = _ref[i];
                if (this.$el.data(i) != null) {
                    this.options[i] = this.$el.data(i);
                }
            }
            this.createStars();
            this.syncRating();
            this.$el.on('mouseover.starrr', 'span', function(e) {
                return _this.syncRating(_this.$el.find('span').index(e.currentTarget) + 1);
            });
            this.$el.on('mouseout.starrr', function() {
                return _this.syncRating();
            });
            this.$el.on('click.starrr', 'span', function(e) {
                return _this.setRating(_this.$el.find('span').index(e.currentTarget) + 1);
            });
            this.$el.on('starrr:change', this.options.change);
        }

        Starrr.prototype.createStars = function() {
            var _i, _ref, _results;

            _results = [];
            for (_i = 1, _ref = this.options.numStars; 1 <= _ref ? _i <= _ref : _i >= _ref; 1 <= _ref ? _i++ : _i--) {
                _results.push(this.$el.append("<span class='glyphicon .glyphicon-star-empty'></span>"));
            }
            return _results;
        };

        Starrr.prototype.setRating = function(rating) {
            if (this.options.rating === rating) {
                rating = void 0;
            }
            this.options.rating = rating;
            this.syncRating();
            return this.$el.trigger('starrr:change', rating);
        };

        Starrr.prototype.syncRating = function(rating) {
            var i, _i, _j, _ref;

            rating || (rating = this.options.rating);
            if (rating) {
                for (i = _i = 0, _ref = rating - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
                    this.$el.find('span').eq(i).removeClass('glyphicon-star-empty').addClass('glyphicon-star');
                }
            }
            if (rating && rating < 5) {
                for (i = _j = rating; rating <= 4 ? _j <= 4 : _j >= 4; i = rating <= 4 ? ++_j : --_j) {
                    this.$el.find('span').eq(i).removeClass('glyphicon-star').addClass('glyphicon-star-empty');
                }
            }
            if (!rating) {
                return this.$el.find('span').removeClass('glyphicon-star').addClass('glyphicon-star-empty');
            }
        };

        return Starrr;

    })();
    return $.fn.extend({
        starrr: function() {
            var args, option;

            option = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
            return this.each(function() {
                var data;

                data = $(this).data('star-rating');
                if (!data) {
                    $(this).data('star-rating', (data = new Starrr($(this), option)));
                }
                if (typeof option === 'string') {
                    return data[option].apply(data, args);
                }
            });
        }
    });
})(window.jQuery, window);

$(function() {
    return $(".starrr").starrr();
});

$(document).ready(function() {

    $('#stars').on('starrr:change', function(e, value) {
        $('#count').html(value);
    });

    $('#stars-existing').on('starrr:change', function(e, value) {
        $('#count-existing').html(value);
    });
});


$(document).ready(function() {

    var sync1 = $("#More-Deals");
    var sync2 = $("#More-Deals-two");
    var slidesPerPage = 1;
    var syncedSecondary = true;
    sync1.owlCarousel({
        items: 1,
        nav: true,
        autoplay: false,
        dots: true,
        loop: true,
		navText: ['<svg width="20px" height="20px" viewBox="0 0 11 20"><path style="fill:none;stroke-width: 1px;stroke: #167bcb;" d="M9.554,1.001l-8.607,8.607l8.607,8.606"/></svg>', '<svg width="20px" height="20px" viewBox="0 0 11 20" version="1.1"><path style="fill:none;stroke-width: 1px;stroke: #167bcb;" d="M1.054,18.214l8.606,-8.606l-8.606,-8.607"/></svg>'],
      
    }).on('changed.owl.carousel', syncPosition);

    sync2
 
        .owlCarousel({
            items: 1,
            dots: true,
            nav: true,
			loop: true,
			navText: false,
            //alternatively you can slide by 1, this way the active slide will stick to the first item in the second carousel

        });

    function syncPosition(el) {
        //if you set loop to false, you have to restore this next line
        //var current = el.item.index;

        //if you disable loop you have to comment this block
        var count = el.item.count - 1;
        var current = Math.round(el.item.index - (el.item.count / 2) - .5);

        if (current < 0) {
            current = count;
        }
        if (current > count)  {
            current = 0;
        }

        //end block

        sync2
            .find(".owl-item")
            .removeClass("current")
            .eq(current)
            .addClass("current");
        var onscreen = sync2.find('.owl-item.active').length - 1;
        var start = sync2.find('.owl-item.active').first().index();
        var end = sync2.find('.owl-item.active').last().index();

        if (current > end) {
            sync2.data('owl.carousel').to(current, 100, true);
        }
        if (current < start) {
            sync2.data('owl.carousel').to(current - onscreen, 100, true);
        }
    }

    function syncPosition2(el) {
        if (syncedSecondary) {
            var number = el.item.index;
            sync1.data('owl.carousel').to(number, 100, true);
        }
    }

    sync2.on("click", ".owl-item", function(e) {
        e.preventDefault();
        var number = $(this).index();
        sync1.data('owl.carousel').to(number, 300, true);
    });
});

$(document).ready(function() {
    $(".fliterdropdown dt a").click(function() {
        $(".fliterdropdown dd ul").toggle();
    });

    $(".fliterdropdown dd ul li span").click(function() {
        var text = $(this).html();
        $(".fliterdropdown dt a span").html(text);
        $(".fliterdropdown dd ul").hide();
    });
    $(document).bind('click', function(e) {
        var $clicked = $(e.target);
        if (!$clicked.parents().hasClass("fliterdropdown"))
            $(".fliterdropdown dd ul").hide();
    }); 
});

$('.responsive-tabs').responsiveTabs({
  accordionOn: ['xs'] // xs, sm, md, lg 
});