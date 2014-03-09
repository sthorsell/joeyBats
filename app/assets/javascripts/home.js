$(document).on("click", ".open-myModal", function () {
	
     var myBookId = $(this).data('id');
     $("#cafeId").val( myBookId );
     $("#player_pcafeID1").val( myBookId );
	$("#player_cafeID1").val( $("#cafeId").val() );
	// $("#avg").text( myBookId );
	// $('#t').load('/players/1');

	$.ajax({
	  cache: false,
	  type:    "GET",
	  url:     "/players/" + myBookId, // see the code below
	  error: function() {
	    // handling with 'xhr', 'status' and 'ex' variables
	    console.log("error");
	  },
	  success: function(t) {
		console.log(t)
	    // handling with 'xhr', 'status' and 'ex' variables
	  }
	
	});
	
	// $.getJSON("/players/" + myBookId, function(data) {
	//     for (var i in data) {
	//         $('input[id="' + 'player_' +i+'"]').val(data[i]);
	//     }
	// });
	
	
	
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
		$("#player_pteamPos").val(obj.tp);
	});
	
	
	
});



