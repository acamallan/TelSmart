<%@include file="../header.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_rest_table_details";
fields = "table_id as rowid, table_id, table_type, table_status";
where = "table_id";
/*used in Add New*/
enableFields = "table_id, table_type, table_status";
/*used in Amend*/
amendableFields = "table_type, table_status";
requiredFields = "table_id, table_type, table_status";
/*End here*/

pageMode = "N,E,D";

%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px;  height: 150px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Room Details</legend>
    <div style="position:relative; z-index:0;">
        <div class="block" style="margin-left: 100px; top: 0px;">
            <label id="lb_table_id">Table ID</label>
            <input type="text" name="table_id" id="table_id" onkeypress='validate(event);' maxlength="4" style="width:50px;" onblur="LostFocus('LF_table_id()')">
        </div>
        <div class="block" style="margin-left: 100px; top: 30px;">
            <label id="lb_table_type">Table type</label>
            <select name="table_type" id="table_type">
            </select>
        </div>
        <div class="block" style="margin-left: 100px; top: 60px;">
            <label id="lb_table_status">Table status</label>
            <select name="table_status" id="table_status">
            </select>
        </div>
    </div>
</fieldset>
<%@include file="rest_table_details_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>