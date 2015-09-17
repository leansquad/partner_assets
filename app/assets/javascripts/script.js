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