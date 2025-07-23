function first_page(){
    if(document.getElementById("current_page").value == 0 && document.getElementById("current_page").value != ""){
	alert('First page already');
        return;
    }
    var table = document.getElementById("table").value;
    var lstFields = document.getElementById("lstFields").value;
    var whereField = document.getElementById("hd_flrField").value;
    var whereValue = document.getElementById("hd_flrValue").value;
    if(whereValue == ""){
        var where = "";
    } else {
        var where = "lower("+whereField +") like lower('%"+whereValue+"%')";
    }
    
    var orderby = "";
    var limit = "0,15";
    var record_count= 0;
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:"displayFilter", table:table, lstFields:lstFields, where: where, orderby:orderby, limit:limit},
        type: 'GET',
        success: function(response) {
            response = response.trim();
            sessionStorage.setItem('response', response);
            response = response.split('~');
            var diplay = "<div class='pageRecordFilter'><table><thead><tr>";
            var fields = document.getElementById("lstFields").value;
            var field = fields.split(',');
            for (var x=1; x < 3; x++){
                diplay = diplay + " <th style='padding: 0.5em 1.5em;'>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
            }
            diplay = diplay + " </tr></thead>";  
            for (var i=0; i < response.length; i++){
                var diplay = diplay + "<tr>";
                var value = response[i].split('^');
                for (var x=1; x < 3; x++){
                    diplay = diplay + "<td style='padding: 0.5em 1.5em;'><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                }
                var diplay = diplay + "</tr>";
            }
            var diplay = diplay + "</table></div>";
            document.getElementById("displayFilter").innerHTML = diplay;
            document.getElementById("current_page").value = record_count;
            if(document.getElementById("mode").value === ""){
                DisplayRecord(0);
            }
        }
    });
}


function previous_page(){
    var record_count = "";
    if(document.getElementById("current_page").value == 0 && document.getElementById("current_page").value != ""){
        alert('First page already');
	return;
    }
    var table = document.getElementById("table").value;
    var lstFields = document.getElementById("lstFields").value;
    var record_count= parseInt(document.getElementById("current_page").value) - 15;
    var whereField = document.getElementById("hd_flrField").value;
    var whereValue = document.getElementById("hd_flrValue").value;
    if(whereValue == ""){
        var where = "";
    } else {
        var where = "lower("+whereField +") like lower('%"+whereValue+"%')";
    }
    var orderby = "";
    var limit = record_count+",15";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:"displayFilter", table:table, lstFields:lstFields, where: where, orderby:orderby, limit:limit},
        type: 'GET',
        success: function(response) {
            response = response.trim();
            sessionStorage.setItem('response', response);
            response = response.split('~');
            var diplay = "<div class='pageRecordFilter'><table><thead><tr>";
            var fields = document.getElementById("lstFields").value;
            var field = fields.split(',');
            for (var x=1; x < 3; x++){
                diplay = diplay + " <th style='padding: 0.5em 1.5em;'>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
            }
            diplay = diplay + " </tr></thead>";  
            for (var i=0; i < response.length; i++){
                var diplay = diplay + "<tr>";
                var value = response[i].split('^');
                for (var x=1; x < 3; x++){
                    diplay = diplay + "<td style='padding: 0.5em 1.5em;'><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                }
                var diplay = diplay + "</tr>";
            }
            var diplay = diplay + "</table></div>";
            document.getElementById("displayFilter").innerHTML = diplay;
            document.getElementById("current_page").value = record_count;
            if(document.getElementById("mode").value === ""){
                DisplayRecord(0);
            }
        }
    });
}

function next_page(){
    var record_count = "";
    var pagefromDB = "";
    var pagefromHTML = "";
    var table = document.getElementById("table").value;
    var lstFields = document.getElementById("lstFields").value;
    var whereField = document.getElementById("hd_flrField").value;
    var whereValue = document.getElementById("hd_flrValue").value;
    if(whereValue == ""){
        var where = "";
    } else {
        var where = "lower("+whereField +") like lower('%"+whereValue+"%')";
    }
    var orderby = "";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
	data: {functionname:"getTotalRecord", table:table, where:where},
	type: 'GET',
        success: function(response) {  
            response = response.trim();
            pagefromDB = parseInt(response/15);
            pagefromHTML = parseInt(document.getElementById("current_page").value/15);
            var checkDec = (response/15).toString();
            if(checkDec.indexOf(".") == "-1"){
                pagefromDB = parseInt(pagefromDB - 1);
            }
            if(pagefromHTML >= pagefromDB || response == 15){
                alert('Last page already');
		HideLoading();
		return;
            } else {
                var record_count= parseInt(document.getElementById("current_page").value) + 15;
                var limit = record_count+",15";
                $.ajax({
                    url: baseURL()+'functions/record_functionjs.jsp',
                    data: {functionname:"displayFilter", table:table, lstFields:lstFields, where: where, orderby:orderby, limit:limit},
                    type: 'GET',
                    success: function(response) {
                        response = response.trim();
                        sessionStorage.setItem('response', response);
                        response = response.split('~');
                        var diplay = "<div class='pageRecordFilter'><table><thead><tr>";
                        var fields = document.getElementById("lstFields").value;
                        var field = fields.split(',');

                        for (var x=1; x < 3; x++){
                           diplay = diplay + " <th>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
                        }
                        diplay = diplay + " </tr></thead>";  
                        for (var i=0; i < response.length; i++){
                            var diplay = diplay + "<tr>";
                            var value = response[i].split('^');
                            for (var x=1; x < 3; x++){
                                diplay = diplay + "<td><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                            }
                            var diplay = diplay + "</tr>";
                        }
                        var diplay = diplay + "</table></div>";
                        document.getElementById("displayFilter").innerHTML = diplay;
                        document.getElementById("current_page").value = record_count;
                        if(document.getElementById("mode").value === ""){
                            DisplayRecord(0);
                        }
                    }
                });
            } 
	}
    });
}

function last_page(){
    var record_count = "";
    var pagefromDB = "";
    var pagefromHTML = "";
    var table = document.getElementById("table").value;
    var lstFields = document.getElementById("lstFields").value;
    var whereField = document.getElementById("hd_flrField").value;
    var whereValue = document.getElementById("hd_flrValue").value;
    if(whereValue == ""){
        var where = "";
    } else {
        var where = "lower("+whereField +") like lower('%"+whereValue+"%')";
    }
    var orderby = "";
    $.ajax({
        url: baseURL()+'functions/record_functionjs.jsp',
        data: {functionname:"getTotalRecord", table:table, where:where},
	type: 'GET',
        success: function(response) {  
            response = response.trim();
            pagefromDB = parseInt(response/15);
            pagefromHTML = parseInt(document.getElementById("current_page").value/15);
            var checkDec = (response/15).toString();
            if(checkDec.indexOf(".") == "-1"){
                pagefromDB = parseInt(pagefromDB - 1);
            }
            if(pagefromHTML >= pagefromDB || response == 15){
                alert('Last page already');
		HideLoading();
                return;
            } else {
		record_count= pagefromDB * 15;
		var limit = record_count+",15";
		$.ajax({
                    url: baseURL()+'functions/record_functionjs.jsp',
                    data: {functionname:"displayFilter", table:table, lstFields:lstFields, where: where, orderby:orderby, limit:limit},
                    type: 'GET',
                    success: function(response) {
                        response = response.trim();
                        sessionStorage.setItem('response', response);
                        response = response.split('~');
                        var diplay = "<div class='pageRecordFilter'><table><thead><tr >";
                        var fields = document.getElementById("lstFields").value;
                        var field = fields.split(',');
                        for (var x=1; x < 3; x++){
                            diplay = diplay + " <th style='padding: 0.5em 1.5em;'>"+capitalizeEachWord(field[x].replace(/_/g," "))+"</th>";
                        }
                        diplay = diplay + " </tr></thead>";  
                        for (var i=0; i < response.length; i++){
                            var diplay = diplay + "<tr>";
                            var value = response[i].split('^');
                            for (var x=1; x < 3; x++){
                                diplay = diplay + "<td style='padding: 0.5em 1.5em;'><div onclick=\'DisplayRecord(\""+i+"\")\' style='cursor:pointer;'>" + value[x] + "</div></td>";
                            }
                            var diplay = diplay + "</tr>";
                        }
                        var diplay = diplay + "</table></div>";
                        document.getElementById("displayFilter").innerHTML = diplay;
                        document.getElementById("current_page").value = record_count;
                        if(document.getElementById("mode").value === ""){
                            DisplayRecord(0);
                        }
                    }
                });
            }
	}
    });
}