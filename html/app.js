

window.addEventListener("message", function(event) {
    var v = event.data  
    var datos = v.dato
    var dollar = Intl.NumberFormat('en-US');
    
    switch (v.action) {
        case 'showData': 
            $('.idjs').html('ID: '+v.pid)
            $('.namejs').html(v.pname)
            $('.banner img').attr('src', datos.avatar)
            $('.banner').css({'background-image':'url('+datos.banner+')'})
            $('.fa-siren-on span').html(datos.police)
            $('.fa-ambulance span').html(datos.ems)
            $('.fa-car-mechanic span').html(datos.meca)
            $('.jobjs').html(datos.job)
            $('.gradejs').html(datos.grade)
            $('.moneyjs').html(' $ '+datos.money)
            $('.bankjs').html(' $ '+datos.bank)
            $('.blackjs').html(' $ '+datos.black)
            $('.pcount h2').html(datos.totalplayers+'/'+v.maxp)
            $('.container').fadeIn(500)
            setTimeout(() => {
                $('.container').fadeOut(500)
            }, 5000);
        break;

        case 'move':
            $('.container').fadeIn(500)
            $('.container').draggable({
                drag: function(event, ui){
                  dragpositionContainerTop = ui.position.top;
                  dragpositionContainerRight = ui.position.left;
                  localStorage.setItem("containerTop", dragpositionContainerTop);
                  localStorage.setItem("containerLeft", dragpositionContainerRight);
                }
            });
        break;

        case 'stopmove': 
            $('.container').fadeOut(500)
        break;
    }
    $(document).keyup((e) => {
        if (e.key === "Escape") {
            setTimeout(() => {
                $.post('https://Roda_InfoPanel/exit', JSON.stringify({}));
            }, 300);
        }
    });
        
});  



window.addEventListener('load', () => {
    $('.container').hide()
    setPosition();
});


const setPosition = ()=> {
    $(".container").animate({ top: localStorage.getItem("containerTop"), left: localStorage.getItem("containerLeft") });
}

