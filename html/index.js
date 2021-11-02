const doc = document;
window.addEventListener('load', () => {
    this.addEventListener('message', e => {
        if (e.data.trans) {
            const accounts = e.data.trans.accounts;
            const jobs = e.data.trans.jobs;
            const player = e.data.trans.playerData;

            $("#bannerdiscord").attr("src", player.banner);
            $("#fotodiscord").attr("src", player.avatar);
            $("#ambulance").html(` ${jobs.ems}`)
            $("#pol").html(jobs.police)
            $("#mech").html(jobs.mechanic)
            $("#Name").html(`ID: <span style = "color:red;">${player.id} </span> ${player.name}`)
            $("#money").html(accounts.money)
            $("#black").html(accounts.black)
            $("#bank").html(accounts.bank)
            $("#jobname").html(player.job.label)
            $("#gradename").html(player.job.grade_label)
            $("#players").html(`${player.players}/${player.maxPlayers}`)

            $(".formulario").fadeIn(player.fadeIn);
            setTimeout(() => {
                $(".formulario").fadeOut(player.fadeOut);
            }, player.fadeOut);
        }
    })
})
