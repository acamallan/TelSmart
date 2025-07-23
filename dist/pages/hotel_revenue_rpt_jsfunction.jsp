<script>

$(function() {
    SetValue("date_from","");
    SetValue("date_to","");
    SetValue("location","0");
    $('#displayList').empty();
    SetFocus("date_from");
});

function LF_date_from(){
    checkDate(document.getElementById("date_from"));
}

function LF_date_to(){
    checkDate(document.getElementById("date_to"));
}

function ProcessReport(){
    if(GetValue("date_from") === "" || GetValue("date_to") === ""){
        alert("Please input the date fields");
        return;
    }
    SetValueInner("datefrom",GetValue("date_from"));
    SetValueInner("dateto",GetValue("date_to"));
    if(GetValue("location") === "0"){
        var qrySelect = "select transaction_date, sales_invoice_number, transaction_amount, user_fullname, location from view_hotel_revenue"
                    + " where to_date(transaction_date) >= '"+to_date(GetValue("date_from"))+"' and to_date(transaction_date) <= '"+to_date(GetValue("date_to"))+"'"
                    + " order by sales_invoice_number";
    } else {
        var qrySelect = "select transaction_date, sales_invoice_number, transaction_amount, user_fullname, location from view_hotel_revenue"
                    + " where to_date(transaction_date) >= '"+to_date(GetValue("date_from"))+"' and to_date(transaction_date) <= '"+to_date(GetValue("date_to"))+"'"
                    + " and location = '"+GetValue("location")+"' order by sales_invoice_number";
    }
    
    var result = SelectDB(qrySelect);
    result = result.split('~');
    var totalAmount = 0;
    var rdisplay = "";
    var rtotal = 0;
    var rcount = 0;
    var pdisplay = "";
    var ptotal = 0;
    var pcount = 0;
    if(result != ""){
        for (var i=0; i < result.length; i++){
            var value = result[i].split('^');
            if(value[4] === "1"){// room
                rtotal = parseInt(rtotal) + parseInt(value[2]);
                rdisplay = rdisplay + "<tr>";                
                    rdisplay = rdisplay + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
                    rdisplay = rdisplay + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
                    rdisplay = rdisplay + "<td style='padding:4px; text-align:right;'>" + value[2] + "</td>";
                    rdisplay = rdisplay + "<td style='padding:4px;'>" + value[3] + "</td>";
                rdisplay = rdisplay + "</tr>";
                rcount++;
            }
            
            if(value[4] === "2"){//POS
                ptotal = parseInt(ptotal) + parseInt(value[2]);
                pdisplay = pdisplay + "<tr>";                
                    pdisplay = pdisplay + "<td style='padding:4px; text-align:center;'>" + value[0] + "</td>";
                    pdisplay = pdisplay + "<td style='padding:4px; text-align:center;'>" + value[1] + "</td>";
                    pdisplay = pdisplay + "<td style='padding:4px; text-align:right;'>" + value[2] + "</td>";
                    pdisplay = pdisplay + "<td style='padding:4px;'>" + value[3] + "</td>";
                pdisplay = pdisplay + "</tr>";
                pcount++;
            }
        }
        if(rcount !== 0){//room
            rdisplay = rdisplay + "<tr>";                
            rdisplay = rdisplay + "<td style='padding:4px; text-align:center;'><b>Subtotal</b></td>";
            rdisplay = rdisplay + "<td style='padding:4px; text-align:center;'><b>" + rcount + "</b></td>";
            rdisplay = rdisplay + "<td style='padding:4px; text-align:right;'><b>" + rtotal.toFixed(2) + "</b></td>";
            rdisplay = rdisplay + "<td style='padding:4px;'></td>";
            rdisplay = rdisplay + "</tr>";
            var rTitle = "<u><b>Room Transactions</b></u>";
        }
        
        if(pcount !== 0){//POS
            pdisplay = pdisplay + "<tr>";                
            pdisplay = pdisplay + "<td style='padding:4px; text-align:center;'><b>Subtotal</b></td>";
            pdisplay = pdisplay + "<td style='padding:4px; text-align:center;'><b>" + pcount + "</b></td>";
            pdisplay = pdisplay + "<td style='padding:4px; text-align:right;'><b>" + ptotal.toFixed(2) + "</b></td>";
            pdisplay = pdisplay + "<td style='padding:4px;'></td>";
            pdisplay = pdisplay + "</tr>";
            var pTitle = "<u><b>POS Transactions</b></u>";
        }
    }
    $('#displayList').empty();
    if(rcount !== 0){ //room
        $('#displayList').append(
            '<tr><td><p style="font-size:12px; margin-top:10px;">'+ rTitle +'</p>'
            + ' <table><tr><thead>'
                + ' <th style="width:25%; text-align:center;">Transaction Date</th>'
                + ' <th style="width:20%; text-align:center;">SI Number</th>'
                + ' <th style="width:20%; text-align:center;">Amount</th>'
                + ' <th style="width:35%; text-align:center;">Employee</th>'
            + ' </tr></thead><tbody>'+rdisplay+'</tbody></table>'
            + ' </td></tr>'
        );
    }
    
    if(pcount !== 0){ //POS
        $('#displayList').append(
            '<tr><td><p style="font-size:12px; margin-top:10px;">'+ pTitle +'</p>'
            + ' <table><tr><thead>'
                + ' <th style="width:25%; text-align:center;">Transaction Date</th>'
                + ' <th style="width:20%; text-align:center;">SI Number</th>'
                + ' <th style="width:20%; text-align:center;">Amount</th>'
                + ' <th style="width:35%; text-align:center;">Employee</th>'
            + ' </tr></thead><tbody>'+pdisplay+'</tbody></table>'
            + ' </td></tr>'
        );
    }
    
    var countTotal = pcount + rcount;
    totalAmount = ptotal + rtotal;
    
    $('#displayList').append(
        '<tr><td><p></p><p></p>'
        + ' <table><tr><tbody>'
            + ' <td style="width:25%; text-align:center; font-weight:bold;">Total</td>'
            + ' <td style="width:20%; text-align:center; font-weight:bold;">'+countTotal+'</td>'
            + ' <td style="width:20%; text-align:right; font-weight:bold;">'+totalAmount.toFixed(2)+'</td>'
            + ' <td style="width:35%; text-align:center;"></td>'
        + ' </tr></tbody></table>'
        + ' </td></tr>'
    );
    
    SetValueInner("printdate",getServerSession("record_date"));
    SetValueInner("printtime",currentTime());
    SetValueInner("gby",getServerSession("firstname") + " " + getServerSession("lastname"));
    
    if(totalAmount === 0){
        DisabledExportBtn();
    } else {
        EnabledExportBtn();
    }
    SetValue("reportname","hotel_revenue");     
}
</script>