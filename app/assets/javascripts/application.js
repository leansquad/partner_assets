// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-1.10.2.min
//= require_tree .


/**
 * Created by kult on 14.09.2015.
 */
$( document ).ready(function() {
    //$(function() {
    //    $( '.wrapper' ).tooltip();
    //});
    //$(function() {
    //    $( '#accordion' ).accordion({
    //        accordion: false,
    //        collapsible: false,
    //        autoHeight: false,
    //        heightStyle: "content",
    //        active: 1
    //    });
    //});
    $('#accordion h1, #accordion h3').click(function(){
        $(this).toggleClass('active');
        $(this).next('.section').slideToggle(500);
        e.preventDefault();
    });
    $('[title]').qtip({
        style: {
            classes: 'tooltip-form',
            background: '#999',
            tip:
            {
                corner: 'left center',
                width: 15,
                height: 15
            }
        },
        position: {
            my: 'left center',
            at: 'right center',
        }
    });
});