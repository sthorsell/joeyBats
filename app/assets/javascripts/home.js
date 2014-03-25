$(document).on("click", ".open-myModal", function () {
	
     var myBookId = $(this).data('id');
     var teamId = $(this).data('teamid');
     $("#cafeId").val( myBookId );
     $("#pcafeID1").val( myBookId );
     $("#player_pcafeID1").val( myBookId );
	$("#player_cafeID1").val( $("#cafeId").val() );
	
	
	$.getJSON("/players/" + myBookId, function(data) {

		console.log(data)
	    for (var i in data) {
			$("#" + i).text( data[i] );
	    }

		var obj = $.parseJSON(JSON.stringify(data));
		if(obj.espnValue == null)
			obj.espnValue = ''


		$("#name").text(obj.first + ' ' + obj.position + ' ' + obj.mlbTeam);
		$("#pname").text(obj.first + ' ' + obj.position + ' ' + obj.mlbTeam);
		
		$("#right").text('ESPNValue: $' + obj.espnValue);
		$("#pright").text('ESPNValue: $' + obj.espnValue);
		// console.log(obj.notes)
		// console.log(obj.sbcValue)
		if(obj.notes != null){
			$("#player_notes").text(obj.notes);
			$("#player_pnotes").text(obj.notes);
		}
	
		$("#player_espnNotes").text(obj.espnNotes);
		$("#player_pespnNotes").text(obj.espnNotes);
		
		$("#player_sbcValue").val(obj.sbcValue);
		$("#player_psbcValue").val(obj.sbcValue);
		$("#player_teamSelect").val(obj.team_id);
		$("#player_pteamSelect").val(obj.team_id);
		$("#player_teamPos").val(obj.tp);
		$("#player_pteamPos").val(obj.starter_id);

		$.getJSON("/teams/" + teamId, function(data) {

		console.log(data);
		$('#player_pteamPos').empty();
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true && index != obj.starter_id) {
				opt.prop("disabled", true); 
			}
    		$('#player_pteamPos').append(opt);
		});
		$('#player_pteamPos').val(obj.starter_id);

		$('#player_teamPos').empty();
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true) {
				opt.prop("disabled", true); 
			}
    		$('#player_teamPos').append(opt);
		});
	});
	});

	
	
	
});

    // $('form[data-async]').on('submit', function(event) {
    	$(document).on("submit", "form[data-async]", function () {

        var $form = $(this);
        var target = $($form.attr('data-target'));
        alert($form.serialize());
        $.ajax({
            url: '/updatePlayer/5',
            data: $form.serialize(),
            dataType: "JSON" 
        });


    });


