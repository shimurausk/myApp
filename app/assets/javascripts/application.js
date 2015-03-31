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
//= require moment.min
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .



//= require jquery-ui.custom.min
//= require fullcalendar.min
//= require lang-all


//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
$(function(){
 //slide
	// $('.Slide .Btn').click(function() {
 //      var Inner= $(this).parent().children('.Inner');
 //      Inner.toggle();
 //  });
  $('.search_btn').click(function(){
      if($('#datetimepicker1 input').val().length>0){
          var date = $('#datetimepicker1 input').val().split(/\s/)[0].replace(/\//g,'-');
          location.href = '/reservations/list/' +date;
      } else {
          $(this).parents('.reservation').find('.error_date').css('display','block');
          return  false;
      }
  })

  $('.dash select').change(function(event) {
    var starttime = new Date($(this).parents('.block').children('.start').children().val()).getTime();
    var endtime = new Date($(this).parents('.block').children('.end').children().val()).getTime();

    if( endtime - starttime <= 0 ){
      $(this).parents('.block').children('.time').children().addClass('error');
    } else {
      $(this).parents('.block').children('.time').children().removeClass('error');
    }

  });

})