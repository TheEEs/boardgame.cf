$(document).on('turbolinks:load', function() {
    $("input#user_avatar").change(function(){
        var file = $(this).prop("files")[0]
        var fileReader = new FileReader()

        fileReader.addEventListener("load", function(){
            $("img#user-avatar-preview").attr("src",fileReader.result)
        })
        fileReader.readAsDataURL(file)
    })
    $("section#avatar-section .image").dimmer({
        on: 'hover'
    });
    $('button#location-get-button').click(function(e){
        e.preventDefault();
        $('#location-input-field').addClass("loading disabled")
        geolocator.locate(options, function (err, location) {
            if (err) return console.log(err);
            $.getJSON(`/user/geosearch?longitude=${location.coords.longitude}&latitude=${location.coords.latitude}`)
            .done(function(data){
                $('#location-text-field').val(data.result)
                $('#location-input-field').removeClass('loading disabled')
            }).fail(function(){
                $('#location-input-field').removeClass('loading disabled')
                console.log("Sorry")
            })
        })
    })
});