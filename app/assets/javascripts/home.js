$(document).ready(function() 
    { 

    	$(".drag").tableDnD();
        $("#mainTable").tablesorter(
        	{
	theme : "bootstrap",
    // hidden filter input/selects will resize the columns, so try to minimize the change
    widthFixed : false,

    // initialize zebra striping and filter widgets
    widgets: ["zebra", "filter"],

    // headers: { 5: { sorter: false, filter: false } },

    widgetOptions : {


      // Add select box to 4th column (zero-based index)
      // each option has an associated function that returns a boolean
      // function variables:
      // e = exact text from cell
      // n = normalized value returned by the column parser
      // f = search filter input value
      // i = column index
      filter_functions : {

         // Add select menu to this column
        // set the column value to true, and/or add "filter-select" class name to header
        // 0 : true,

        // Add these options to the select dropdown (regex example)
        1: {
          "1B" : function(e, n, f, i, $r) { return e.indexOf('1B') > -1; },
		  "2B" : function(e, n, f, i, $r) { 
		  	return e.indexOf('2B') > -1; },
		  "SS" : function(e, n, f, i, $r) { return e.indexOf('SS') > -1; },
		  "3B" : function(e, n, f, i, $r) { return e.indexOf('3B') > -1; },
		  "MI" : function(e, n, f, i, $r) { return e.indexOf('2B') > -1 
		  	||e.indexOf('SS') > -1; },
		  "CI" : function(e, n, f, i, $r) { return e.indexOf('1B') > -1
		  	||e.indexOf('3B') > -1; },
		  "OF" : function(e, n, f, i, $r) { return e.indexOf('OF') > -1; },
		  "SP" : function(e, n, f, i, $r) { return e.indexOf('SP') > -1; },
		  "RP" : function(e, n, f, i, $r) { return e.indexOf('RP') > -1; },
        }
      }

    }

  }); 
    } 
); 
   

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

		var title = obj.first + ' ' + obj.position + ' ' + obj.mlbTeam + ' ' + 'Starter:' + obj.starter + ' ' + "Majors:" + obj.majorStatus;
		$("#name").text(title);
		$("#pname").text(title);
		
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
		$("#pInjury").text(obj.injuryNotes);
		$("#injury").text(obj.injuryNotes);

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
			if(value[1] === true && index != obj.starter_id) {
				opt.prop("disabled", true); 
			}
    		$('#player_teamPos').append(opt);
		});
		$('#player_teamPos').val(obj.starter_id);
		});
	});
});

$(document).on("change", "#player_teamSelect", function () {
	// Refactor this into position load above	
     var myBookId = $(this).data('id');
     var teamId = this.value;

		$.getJSON("/teams/" + teamId, function(data) {

		console.log(data);
		$('#player_pteamPos').empty();
		$('#player_pteamPos').append($("<option></option>").attr("value",-1).text('Select'));
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true) {
				opt.prop("disabled", true); 
			}
    		$('#player_pteamPos').append(opt);
		});
		$('#player_pteamPos').val(-1);

		$('#player_teamPos').empty();
		$('#player_teamPos').append($("<option></option>").attr("value",-1).text('Select'));
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true) {
				opt.prop("disabled", true); 
			}
    		$('#player_teamPos').append(opt);
		});
		$('#player_teamPos').val(-1);
		
	});	
});
$(document).on("change", "#player_pteamSelect", function () {
	// Refactor this into position load above	
     var myBookId = $(this).data('id');
     var teamId = this.value;

		$.getJSON("/teams/" + teamId, function(data) {

		console.log(data);
		$('#player_pteamPos').empty();
		$('#player_pteamPos').append($("<option></option>").attr("value",-1).text('Select'));
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true) {
				opt.prop("disabled", true); 
			}
    		$('#player_pteamPos').append(opt);
		});
		$('#player_pteamPos').val(-1);

		$('#player_teamPos').empty();
		$('#player_teamPos').append($("<option></option>").attr("value",-1).text('Select'));
		$.each(data, function (index, value) {
			var opt = $("<option></option>").attr("value",index).text(value[0]);
			if(value[1] === true) {
				opt.prop("disabled", true); 
			}
    		$('#player_teamPos').append(opt);
		});
		$('#player_teamPos').val(-1);
		
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


