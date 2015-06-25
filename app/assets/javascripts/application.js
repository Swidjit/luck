// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation

//= require_tree .
//= require spinner
//= require social-share-button

$(function(){ $(document).foundation(); });
$(document).on('ready', function(){
	if ($.cookie('session_id')==undefined) {
		var id = parseInt(Math.random()*1000000000);
		$.cookie('session_id', id, { expires: 1 });
	}
	else console.log($.cookie('session_id'));
	$("#user-menu-icon").show();
	$("#play").hover(
    	function() {
	    	$("#games").stop().toggle('fast');

		},
		function() {
	    	$("#games").stop().toggle('fast');
		}

	);
	$("#user-menu-icon").hover(
    	function() {
	    	$("#user-menu").stop().toggle('fast');

		},
		function() {
	    	$("#user-menu").stop().toggle('fast');
		}

	);

});
$(document).on('ready page:load', function(){

});
