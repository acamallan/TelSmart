/*!
 * BScheduler  v1.1
 * Author: Anthony Camallan
 */
 
(function($) {
	$.fn.BScheduler = function(lists) {
		var divWidth = '1100px'; //default DIV width
		var displayNavButton = true; //hide the navigation buttons
		var occupiedstatus = "red"; //default color for Occupied status
		var reservedstatus = "yellow"; //default color for Reserved status
		var availablestatus = ""; //default color for Available status
		var occupiedstatustxtcolor = "#fff"; //default text color for Available status
		var reservedstatustxtcolor = "#666"; //default text color for Available status
		var availablestatustxtcolor = "#666"; //default text color for Available status
		var room_details = "";
		
		if(lists.displayNavButton !== undefined){
			displayNavButton = lists.displayNavButton;
		}
		
		if(lists.divWidth !== undefined){
			divWidth = lists.divWidth+"px";
		}
		
		//Status color
		if(lists.occupiedstatus !== undefined){
			occupiedstatus = lists.occupiedstatus;
		}
		if(lists.reservedstatus !== undefined){
			reservedstatus = lists.reservedstatus;
		}
		if(lists.availablestatus !== undefined){
			availablestatus = lists.availablestatus;
		}
		
		//Status text color
		if(lists.occupiedstatustxtcolor !== undefined){
			occupiedstatustxtcolor = lists.occupiedstatustxtcolor;
		}
		if(lists.reservedstatustxtcolor !== undefined){
			reservedstatustxtcolor = lists.reservedstatustxtcolor;
		}
		if(lists.availablestatustxtcolor !== undefined){
			availablestatustxtcolor = lists.availablestatustxtcolor;
		}
		function leapYear(year) {
			if (year % 4 == 0){ // basic rule
				return true // is leap year
			} else {
				/* else */ // else not needed when statement is "return"
				return false // is not leap year
			}
		}

		function getLastDayofMonth(month, year) {
			// create array to hold number of days in each month
			var ar = new Array(12);
			ar[0] = 31; // January
			ar[1] = (leapYear(year)) ? 29 : 28; // February
			ar[2] = 31; // March
			ar[3] = 30; // April
			ar[4] = 31; // May
			ar[5] = 30; // June
			ar[6] = 31; // July
			ar[7] = 31; // August
			ar[8] = 30; // September
			ar[9] = 31; // October
			ar[10] = 30; // November
			ar[11] = 31; // December
			return ar[month]
		}

		function getMonthName(month) {
			// create array to hold name of each month
			var ar = new Array(12);
			ar[0] = "January";
			ar[1] = "February";
			ar[2] = "March";
			ar[3] = "April";
			ar[4] = "May";
			ar[5] = "June";
			ar[6] = "July";
			ar[7] = "August";
			ar[8] = "September";
			ar[9] = "October";
			ar[10] = "November";
			ar[11] = "December";
			return ar[month];
		}        
		
		function checkDate(i) {
			if (i < 10) {i = "0" + i;};  // add zero in front of numbers < 10
			return i;
		}
		
		String.prototype.capitalizeFirstLetter = function() {
			return this.charAt(0).toUpperCase() + this.slice(1);
		}

		window.ShowDetails = function(details,checkin_date,checkout_date,status,customer_name) {
			document.getElementById("ShowDetails").style.display = "block";
			$( "#ShowDetails" ).dialog({
				width: 400,
				height: 250,
				position: { my: 'top', at: 'top+100' },
				modal: true,
				open: function(){
					jQuery('.ui-widget-overlay').bind('click',function(){
						jQuery('#ShowDetails').dialog('close');
					})
				},
				close: function() {
					$(this).dialog('destroy');
					document.getElementById("ShowDetails").style.display = "none";
				}
			})
			var check = "CheckIn Date: "+checkin_date+ "<br>Checkout Date: "+ checkout_date + "<br><br>Status: " + status.capitalizeFirstLetter() ;
			if(details !== ""){
				details += "<br><br>";
			}
			if(customer_name !== ""){
				customer_name = "Customer Name: " +customer_name+"<br><br>";
			}
			$("#ShowDetails").html(customer_name + details + check);
        };
		
		window.RoomDetails = function(details) {
			if(details !== ""){
				document.getElementById("ShowDetails").style.display = "block";
				$( "#ShowDetails" ).dialog({
					width: 400,
					height: 250,
					position: { my: 'top', at: 'top+100' },
					modal: true,
					open: function(){
					jQuery('.ui-widget-overlay').bind('click',function(){
						jQuery('#ShowDetails').dialog('close');
					})
				}
				})
				$("#ShowDetails").html(details);
            }
        };
		
		function drawScheduler(firstDayofMonth, lastDayofMonth, monthName, month, year) {
			var display = "";
			
			display += '<div style="margin:auto; position:relative; text-align:center; padding:5px;"><span style="font-size: 150%;">' + monthName + ' ' + year+ '</span>';
			if(displayNavButton){
				display += '<div style="float:right; position:relative;"><input type="button" id="ac_prevMonth" value="<" class="ac_button" title="Previous Month" style="padding:4px 10px 4px 10px; background:#3399cc; border:0; color:#fff; width:40px; cursor:pointer;transition:background .3s; -webkit-transition:background .3s;"/> <input type="button" id="ac_nextMonth" value=">" class="ac_button" title="Next Month" style="padding:4px 10px 4px 10px; background:#3399cc; border:0; color:#fff; width:40px; cursor:pointer;transition:background .3s; -webkit-transition:background .3s;"/></div>';
			}
			display += '</div><table cellspacing="0" class="ac_calendar" id="ac_calendar" style="width:100%;">';
			// create array of abbreviated day names
			var weekDay = new Array(7);
			weekDay[0] = "Sun";
			weekDay[1] = "Mon";
			weekDay[2] = "Tues";
			weekDay[3] = "Wed";
			weekDay[4] = "Thu";
			weekDay[5] = "Fri";
			weekDay[6] = "Sat";

			// create first row of table to set column width and specify week day
			var currentDay = firstDayofMonth;
			var real = new Date();
			var realyear = real.getYear();
			if (realyear < 1000){
				realyear+=1900
			}
			var realMonth = real.getMonth();
			var presentDay = real.getDate();//get the present date so that previous date will not be selected
			display += '<tr><th style="text-align:center;">Room No.</th>'
			for (var dayNum = 0; dayNum < lastDayofMonth; ++dayNum) {
				if(currentDay === 7 ){
					currentDay = currentDay - 7;
				}
				var presentColor = "";
				if(dayNum === presentDay-1 && realMonth === month && realyear === year){
					presentColor = "background-color:orange;";//highlight the present day
				}
				display += '<th style="width:32px; padding-top:2px; padding-bottom2px; text-align:center; '+presentColor+'">' + weekDay[currentDay] + '</th>';
				currentDay++;
			}
			display += '</tr>'

			var digit = 1;
			for (var row = 0; row <= lists.rooms.length-1; row++) {
				var room_id = lists.rooms[row].room_no;
				if(lists.rooms[row].room_details !== undefined){
					room_details = lists.rooms[row].room_details;
				}
				display += '<tr style="text-align:center;"><td onclick="RoomDetails(\''+room_details+'\')" style="width:80px; cursor:pointer;" class="noselect">Room '+room_id+'</td>'
				for (var day = 1; day <= lastDayofMonth+firstDayofMonth; day++) {
					if (digit > lastDayofMonth){
						break
					}
					var statusColor = "background-color:"+availablestatus+"; color:"+availablestatustxtcolor+";";
					var title = "";
					var onclick ="";
					var sched_details = "";
					var customer_name = "";
					var noselect = "";
					if(lists.sched !== undefined){
						var startDay = "";
						for(var sched = 0; sched <= lists.sched.length-1; sched++){
							var sched_room_id = lists.sched[sched].room_no;
							var startDate = new Date(lists.sched[sched].start_date);
							var startMonth = startDate.getMonth();
							startDay = startDate.getDate();
							
							var endDate = new Date(lists.sched[sched].end_date);
							var endMonth = endDate.getMonth();
							var endDay = endDate.getDate();
							var status = lists.sched[sched].status;
							
							if(month > startMonth){// get the first day of the month when Start Date month is lower to Month in calendar
								startDay = 1;
							}
							
							if(month < endMonth){// get the last day of the month when End Date month is higher to Month in calendar
								endDay = lastDayofMonth;
							}
							
							if(lists.sched[sched].sched_details !== undefined){
								sched_details = lists.sched[sched].sched_details;
							}
							
							if(lists.sched[sched].customer_name !== undefined){
								customer_name = lists.sched[sched].customer_name;
							}
					
							if(room_id === sched_room_id ){
								for(var x = startDay; x <= endDay; x++){
									if(x === day){
										if(status.toLowerCase() === "occupied"){
											statusColor = "background-color:"+occupiedstatus+"; cursor:pointer; color:"+occupiedstatustxtcolor+";";
											onclick ='onclick="ShowDetails(\''+sched_details+'\',\''+lists.sched[sched].start_date+'\',\''+lists.sched[sched].end_date+'\',\''+status+'\',\''+customer_name+'\')"';
											noselect = 'class="noselect"';
										} else if(status.toLowerCase() === "reserved"){
											statusColor = "background-color:"+reservedstatus+"; cursor:pointer; color:"+reservedstatustxtcolor+";";
											onclick ='onclick="ShowDetails(\''+sched_details+'\',\''+lists.sched[sched].start_date+'\',\''+lists.sched[sched].end_date+'\',\''+status+'\',\''+customer_name+'\')"';
											noselect = 'class="noselect"';
										} 
									}
								}
							}
						}
					}
					var dateCalendar = new Date(year, month, digit);
					if(real > dateCalendar){
							noselect = 'class="noselect"';
					} 
					
					display += '<td style="text-align:center; padding:5px; '+statusColor+'" '+onclick+' title="'+room_id+'" '+noselect+' id="'+room_id+'_'+year+'-'+checkDate(month)+'-'+checkDate(digit)+'">';
					display += digit;
					display += '</td>';
					digit++;
				}
				display += '</tr>'
				digit = 1;
			}
			display += '</table>';
			display += '<span style="font-weight:bold; margin-left:10px;"> Legend:</span> <div class="square" style="background-color:'+availablestatus+'"></div><span style="font-weight:bold;">Available</span> <div class="square" style="background-color:'+occupiedstatus+'"></div><span style="font-weight:bold;">Occupied</span>  <div class="square" style="background-color:'+reservedstatus+'"></div><span style="font-weight:bold;">Reserved</span> ';
			return display;
		}
		
		 return this.each( function() {
			var monthName = getMonthName(lists.month);
			var date = new Date(lists.year, lists.month, 1);
			var firstDayofMonth = date.getDay();
			var lastDayofMonth = getLastDayofMonth(lists.month, lists.year);
			var display = ""; // initialize variable to empty string
			display += '<div id="ac_scheduler" style="width:'+divWidth+';">';
			display += drawScheduler(firstDayofMonth, lastDayofMonth, monthName, lists.month, lists.year);
			display += '</div>';
			display += '<div id="ShowDetails" title="Details" style="display: none;"></div>';
			display += '<input type="hidden" id="ac_date" value="'+date+'">';
            $(this).html(display);
			if(displayNavButton){
				$( "#ac_prevMonth").click(function() {
					prevMonth();
				});
				$( "#ac_nextMonth").click(function() {
					nextMonth();
				});
			}
			
			var isMouseDown = false;
				$("#ac_calendar td")
					.mousedown(function () {
						
						isMouseDown = true;
							if(!$(this).hasClass("noselect")){
								//$("td").removeClass("highlighted");	
								$(this).toggleClass("highlighted");
							}
							return false; // prevent text selection
					})
					.mouseover(function () {
						if(!$(this).hasClass("noselect")){
							
							if (isMouseDown) {
								
								$(this).toggleClass("highlighted");
							}	
						}
					});
			  
				$(document).mouseup(function () {
					isMouseDown = false;
				});
		});
	}
}(jQuery));


