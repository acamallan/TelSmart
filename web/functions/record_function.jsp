<%!
public Integer AddNewRecord(String table, String fields, String values, String lstFields){
    try{
	table = decrypt(table);
	String[] field = decrypt(fields).split(",");
	String[] value = decrypt(values).split(",");
	Integer strCountFields = decrypt(lstFields).split(",").length;
	Integer strLen = field.length;
	
	Integer diff = (strLen - strCountFields) + 1;
	String strFields = "";
	String strValues = "";
        String username = "";
	for (Integer x = 0; x <= strLen-diff; x++) {
            String CheckValue = "";
            if(field[x].equals("username")){/*restricted column. Used only in was_user_info*/
                username = value[x];
            }
            strFields = strFields + field[x] + ",";
            
            if(field[x].equals("password")){ /*restricted column. Used only in was_user_info*/
                strValues = strValues + "'" + generateHash(username+value[x]) + "',";
            } else if(field[x].equals("role")){ /*restricted column. Used only in was_user_info*/
                if(value[x].equals("1")){
                    strValues = strValues + "'" + EncryptRole(username,value[x]) + "',";
                } else {
                    strValues = strValues + "'" + EncryptRole(username,"0") + "',";
                }               
            } else { 
                CheckValue = value[x].replace("'","''");
                strValues = strValues + "'" + CheckValue + "',";
            }
	}
	strFields = strFields.substring(0, strFields.length() - 1);
        strValues = strValues.substring(0, strValues.length() - 1);
	Integer strReturn = DB_Insert(table,strFields,strValues,"");
        return strReturn;
    }  catch ( Exception err ) {
         Logger("error", "AddNewRecord Function: " + err.getMessage());
    }
return  null;
}

public Integer UpdateRecord(String table, String fields, String values, String where, String id, String lstFields){
    try{
	table = decrypt(table);
	String[] field = decrypt(fields).split(",");
	String[] value = decrypt(values).split(",");
	Integer strCountFields = decrypt(lstFields).split(",").length;
	Integer strLen = field.length;
	
	Integer diff = (strLen - strCountFields) + 1;
	String strSet = "";
	String set = "";
        String username = "";
	for (Integer x = 0; x <= strLen-diff; x++) {
            String CheckValue = "";
            if(field[x].equals("username")){/*restricted column. Used only in was_user_info*/
                username = value[x];
            }
            if(field[x].equals("password")){ /*restricted column. Used only in was_user_info*/
                set = field[x] + "='" + generateHash(username+value[x]) + "'";
            } else if(field[x].equals("role")){ /*restricted column. Used only in was_user_info*/
                if(value[x].equals("1")){
                    set = field[x] + "='" + EncryptRole(username,value[x]) + "'";
                } else {
                    set = field[x] + "='" + EncryptRole(username,"0") + "'";
                }
            } else { 
               CheckValue = value[x].replace("'","''");
               set = field[x] + "='" + CheckValue + "'"; 
            }
            strSet = strSet + set + ",";
            	
	}
	strSet = strSet.substring(0, strSet.length() - 1);
        String strWhere = " " + decrypt(where) + "='" + decrypt(id) + "'";
        Integer strReturn = DB_Update(table,strSet,strWhere,"");
       return strReturn; 
    }  catch ( Exception err ) {
        Logger("error", "UpdateRecord Function: " + err.getMessage());
    }
return  null; 
}

public Integer DeleteRecord(String table, String whereField, String whereValue){
        try {
	String where = "where "+decrypt(whereField)+"="+decrypt(whereValue);
	Integer strReturn = DB_Delete(decrypt(table),where);
	return strReturn; 
    }  catch ( Exception err ) {
        Logger("error", "DeleteRecord Function: " + err.getMessage());
    }
    return null;
}

public String GetCounter(String counter_id, String length){
    try {
    Integer counter = 0;
    ResultSet strCounter = DB_Select(" counter_value", "was_counter","counter_id = '"+counter_id+"'","","");
    while(strCounter.next()){
        counter  = strCounter.getInt("counter_value")+1 ;
        DB_Update("was_counter"," counter_value ='"+counter+"'"," counter_id = '"+counter_id+"'","");
    }
    String strReturn = String.format("%0"+length+"d", counter);
    return strReturn;
    
    }  catch ( Exception err ) {
        Logger("error", "GetCounter Function: " + err.getMessage());
    }
    return null;
}
%>