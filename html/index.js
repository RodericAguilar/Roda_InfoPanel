

$(function(){

    window.addEventListener("message", function(event){

        if ( event.data.trans == true ) {
                var money = event.data.money 
                var job = event.data.job
                $("#bannerdiscord").attr("src",event.data.img);
                $("#fotodiscord").attr("src",event.data.pp);
                $("#ambulance").html(event.data.ems)
                $("#pol").html(event.data.police)
                $("#mech").html(event.data.mech)
                $("#Name").html(event.data.name)
                $("#money").html(money.money)
                $("#black").html(money.black)
                $("#bank").html(money.bank)
                $("#jobname").html(job.label)
                $("#gradename").html(job.grade_label)
                $("#players").html(event.data.players)
                $(".formulario").fadeIn(1000);
                setTimeout(() => {
                    $(".formulario").fadeOut(4000);
                }, 4000);

        }
    })    
})


