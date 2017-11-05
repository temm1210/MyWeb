$('ul li:has(ul)').addClass('has-submenu');
$('ul li ul').addClass('sub-menu');
$('ul.dropdown li').hover(function () {
    $(this).addClass('hover');
}, function () {
    $(this).removeClass('hover');
});

var $menu = $('#menu'), $menulink = $('#spinner-form'), $search = $('#search'), $search_box = $('.search_box'), $menuTrigger = $('.has-submenu > a');
$menulink.click(function (e) {
    $menulink.toggleClass('active');
    $menu.toggleClass('active');
    if ($search.hasClass('active')) {
        $('.menu.active').css('padding-top', '50px');
    }
});
$search.click(function (e) {
    e.preventDefault();
    $search_box.toggleClass('active');
});
$menuTrigger.click(function (e) {
    e.preventDefault();
    var t = $(this);
    t.toggleClass('active').next('ul').toggleClass('active');
});
$('ul li:has(ul)');


$(function () {
	/*아이디 크기를 가져와서 아이다크기에따라 넓이지정*/
	var userIdWidth = $("#user_id").width();
	
	if(userIdWidth < 50)
		userIdWidth = userIdWidth+30;
	else if(userIdWidth > 50 && userIdWidth < 100)
		userIdWidth = userIdWidth+20;
	else
		userIdWidth = userIdWidth+10;
	
	$("#user_id").width(userIdWidth);
	
    var e = $(document).scrollTop();
    var t = $('.wrapper').outerHeight();
});