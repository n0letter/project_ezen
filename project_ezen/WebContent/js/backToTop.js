	// SCROLL EVENT
$(document).ready(function(){
    $(window).scroll(function() {
        var wScroll = $(this).scrollTop();

        if(wScroll > 100) {
            $('.scroll-top').addClass('is-showing');
        } else {
            $('.scroll-top').removeClass('is-showing');
        }
    });

    // SCROLL TOP BUTTON

    $('.scroll-top').on('click', function() {
        $('html, body').animate({scrollTop:0}, '2000', function() {
            $('.scroll-top').removeClass('is-showing');
        });
        return false;

    }); 
});