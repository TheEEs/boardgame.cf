$(document).on('turbolinks:load', function() {
    try{
        var element = document.querySelector("textarea#article_content")
        if(element)
            var simplemde = new SimpleMDE({ 
                element: $("textarea#article_content")[0],
                spellChecker:false 
            });
    }
    catch(e){

    }
    $("#share_article").click(function(){
        $("#share_article_button").click()
    })
    $("a.article-share-link").click(function(){
        var article_id = $(this).data("article-id")
        $(`#article_share_form_${article_id}`).submit()
    })
})