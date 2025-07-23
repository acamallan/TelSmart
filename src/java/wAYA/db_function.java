/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wAYA;

import java.sql.*;
/**
 *
 * @author acamallan
 */
public class db_function {
    Logs WAS = new Logs();
    
    public Integer DB_Update(String table, String setValues, String where, String qryStmt, Connection conn){
        try{
            String qryUpdate = qryStmt+"update "+table+" set "+setValues+" where "+where;
            conn.setAutoCommit(false); 
            String[] Stmt = qryUpdate.split("\\^\\_\\^");
            Integer count = 0;
            Integer strReturn = 0;
            while (count <= Stmt.length-1) {
                PreparedStatement qryStmtPrep = conn.prepareStatement(Stmt[count],Statement.RETURN_GENERATED_KEYS);
                strReturn = qryStmtPrep.executeUpdate();
                count++;
            }
            conn.commit();
            conn.close();
            return strReturn;
        } catch(SQLException err){
            try {
                WAS.Logger("error", "DB_Update Function: " + err.getMessage());
                conn.rollback();
            } catch(Exception err1){
            }
        }
        return null;
    }

    public Integer DB_Insert(String table, String fields, String values, String qryStmt,Connection conn){
        try{
            String qryInsert = qryStmt+"insert into "+table+"( "+fields+" ) values ( "+values+" )";
            conn.setAutoCommit(false); 
            String[] Stmt = qryInsert.split("\\^\\_\\^");
            Integer count = 0;
            Integer strReturn = -1;
            while (count <= Stmt.length-1) {
                PreparedStatement qryStmtPrep = conn.prepareStatement(Stmt[count],Statement.RETURN_GENERATED_KEYS);
                qryStmtPrep.executeUpdate();
                ResultSet generatedKeys = qryStmtPrep.getGeneratedKeys();
                if (generatedKeys.next()) {
                    strReturn = generatedKeys.getInt(1);
                }
                count++;
            }
            conn.commit();
            conn.close();
            return strReturn;
        } catch(SQLException err){
            try {
                WAS.Logger("error", "DB_Insert Function: " + err.getMessage());
                conn.rollback();
            } catch(Exception err1){
            }
        }
        return null;
    }

    public Integer DB_Delete(String table, String where, Connection conn){
        try {
            conn.setAutoCommit(false);
            String qryDelete = "delete from " + table + " " +where;
            Integer strReturn = Delete_DB(qryDelete, conn);
            conn.commit();
            conn.close();
            return strReturn;
        } catch(SQLException err){
            try {
                WAS.Logger("error", "DB_Delete Function: " + err.getMessage());
                conn.rollback();
            } catch(Exception err1){
            }
        }
        return null;
    }

    public ResultSet DB_Select(String fields, String table, String where, String orderby, String limit, Connection conn){
        try {
        if(!orderby.equals("")){
            if(!orderby.contains("order by ")){
                orderby = "order by " + orderby;
            }
        }
        if(!limit.equals("")){
            limit = "limit " + limit;
        }
        if(!where.equals("")){
            where = "where " + where;
        }
        
        PreparedStatement qrySelect = conn.prepareStatement("select " + fields + " from " + table + " " + where + " " + orderby + " " + limit);
        ResultSet resultSet = qrySelect.executeQuery();
        return resultSet;
        } catch(SQLException e){
            WAS.Logger("error", "DB_Select Function: " + e.getMessage());
        }
        return null;
    } 
    
 /* --------------------------------------------------------------------------------------- */   
    public Integer Update_DB(String updateStmt, Connection conn){
        try{
            PreparedStatement qryUpdate = conn.prepareStatement(updateStmt);
            Integer strReturn = qryUpdate.executeUpdate();
            return strReturn;
        } catch(SQLException err){
            WAS.Logger("error", "Update_DB Function: " + err.getMessage());
        }
        return null;
    }

    public Integer Insert_DB(String qryStmt, Connection conn){
        try{
            conn.setAutoCommit(false); 
            String[] Stmt = qryStmt.split("\\^\\_\\^");
            Integer count = 0;
            Integer strReturn = -1;
            while (count <= Stmt.length-1) {
                strReturn = -1;
                PreparedStatement qryInsert = conn.prepareStatement(Stmt[count],Statement.RETURN_GENERATED_KEYS);
                qryInsert.executeUpdate();
                ResultSet generatedKeys = qryInsert.getGeneratedKeys();
                if (generatedKeys.next()) {
                    strReturn = generatedKeys.getInt(1);
                }
                count++;
            }
            conn.commit();
            conn.close();
            return strReturn;
        } catch(SQLException err){
            try {
                WAS.Logger("error", "Insert_DB Function: " + err.getMessage());
                conn.rollback();
            } catch(Exception err1){
            }
        }
        return null;
    }

    public Integer Delete_DB(String deleteStmt, Connection conn){
        try {
            PreparedStatement qryDelete = conn.prepareStatement(deleteStmt);
            Integer strReturn = qryDelete.executeUpdate();
            return strReturn;
        } catch(SQLException err){
            WAS.Logger("error", "Delete_DB Function: " + err.getMessage());
        }
        return null;
    }

    public String Select_DB(String selectStmt, Connection conn){
        try {
        PreparedStatement qrySelect = conn.prepareStatement(selectStmt);
        ResultSet strSelect = qrySelect.executeQuery();
        String strReturn = "";
        if(strSelect.isBeforeFirst()){
            while (strSelect.next()) {
                int total_rows = strSelect.getMetaData().getColumnCount();
                for (int i = 0; i < total_rows; i++) {
                    strReturn = strReturn + strSelect.getString(strSelect.getMetaData().getColumnLabel(i+1))+"^";
                }
                strReturn = strReturn.substring(0, strReturn.length() - 1);
                strReturn = strReturn + "~";
            }
            strReturn = strReturn.substring(0, strReturn.length() - 1);
        }
        return strReturn;
        }  catch ( Exception err ) {
            WAS.Logger("error", "Select_DB Function: " + err.getMessage());
        }
        return null;
    }
}
