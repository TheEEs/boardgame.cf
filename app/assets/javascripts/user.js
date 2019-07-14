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
});