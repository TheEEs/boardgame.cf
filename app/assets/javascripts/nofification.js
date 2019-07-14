function show_noty(text,type){
    new Noty({
        type: type,
        layout:'bottomRight',
        text: text,
        animation: {
            open: 'animated bounceInRight', // Animate.css class names
            close: 'animated bounceOutRight' // Animate.css class names
        },
        timeout: 2000
    }).show();
}