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
			$("#notes").text(obj.notes);
			$("#pnotes").text(obj.notes);
		}
	
		$("#espnNotes").text(obj.espnNotes);
		$("#pespnNotes").text(obj.espnNotes);
		
		$("#sbcValue").val(obj.sbcValue);
		$("#psbcValue").val(obj.sbcValue);
		$("#teamSelect").val(obj.team_id);
		$("#pteamSelect").val(obj.team_id);
		$("#teamPos").val(obj.tp);
		$("#selectedPos").val(obj.starter_id);

		$.getJSON("/teams/" + teamId, function(data) {

		console.log(data);
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value);
			if(value === '') {
				opt.prop("disabled", true); 
			}
    		$('#positionsSelect').append(opt);
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


