$(document).on('turbolinks:load', function() {
    $('#date_hour').change(function(e){
        $('input#order_when_4i').val($(this).val())
    })
    $("#date_minute").change(function(){
        $('input#order_when_5i').val($(this).val())
    })
})