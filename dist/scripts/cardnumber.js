function GenerateCardNumber(bin,len,no_of_entries,record_date,expiry_date,card_type){
    var result="";
    $.ajax({
        url: baseURL()+'functions/cardnumberjs.jsp',
        data: {functionname:"genCardNumbers", bin:bin, len:len, no_of_entries:no_of_entries, record_date:record_date, expiry_date:expiry_date, card_type:card_type},
        type: 'GET',
        async: false,
        success: function(response) {
            result = response.trim();
            if(result == "null"){
                result = "";
            }
        }
    });
    return result;
}