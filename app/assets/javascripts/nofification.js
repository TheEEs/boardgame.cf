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

var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumWait: 10000,     // max wait time for desired accuracy
    maximumAge: 0,          // disable cache
    desiredAccuracy: 30,    // meters
    fallbackToIP: true,     // fallback to IP if Geolocation fails or rejected
};
function update_geolocation(){
    geolocator.locate(options, function (err, location) {
        if (err) return console.log(err);
        $.post("/user/geolocation",{latitude: location.coords.latitude, longitude: location.coords.longitude}).done(function(data){
            $("strong#user-location").text(`(${data})`)
            show_noty(`Cập nhật vị trí thành công(${data})`, "success")
        }).fail(function(){
            show_noty("Không thể cập nhật vị trí của bạn", "error")
        })
    })
}