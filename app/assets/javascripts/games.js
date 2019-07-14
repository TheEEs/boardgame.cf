$(document).on('turbolinks:load', function() {
    $("input#game_image").change(function(){
        var file = $(this).prop("files")[0]
        var fileReader = new FileReader()

        fileReader.addEventListener("load", function(){
            $("img#preview-image").attr("src",fileReader.result)
        })
        fileReader.readAsDataURL(file)
    })
    $('button#share_the_game').click(function(){
        $('input#share_game_button').click()
    })
    $('label.find_by_tag_label').click(function(){
        var tag_id = $(this).data('tag-id')
        $(`form#find_by_tag_form_${tag_id}`).submit()
    })
    $('button#open_filters_modal').click(function(){
        $('.ui.modal').modal('show')
    })
})