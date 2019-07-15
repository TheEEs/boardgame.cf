//= require geolocator
//= require jquery
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require noty
//= require simplemde.min
//= require_tree .

geolocator.config({
    language: "en"
});

$(document).on('turbolinks:load', function() {

    $('table').addClass('ui celled table')
    $('button, input[type="submit"]').addClass("ui button")
    $('.ui.dropdown').dropdown()
    $('.ui.label').css("margin-bottom","4px")
    $('form[data-remote],a[data-remote]').on('ajax:error',function(){
       alert("Error currerd")
    })
    $('#geolocation-update-button').click(function(e){
        update_geolocation()
        //e.preventDefault();
    })
})
