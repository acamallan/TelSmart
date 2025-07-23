<%@include file="../header.jsp"%>

<%
String room_id = "";
if(request.getParameter("link") != null && request.getParameter("room_id") != null){
    room_id = decrypt(request.getParameter("room_id"));
}
/* No need to put String as variables already initialize */
table = "was_hotel_room_details";
fields = "room_id as rowid, room_id, room_type, price, room_status";
where = "room_id";

if(!room_id.equals("")){
    mainWhere = "room_id = '"+room_id+"'";
}
/*used in Add New*/
enableFields = "room_id, room_type, price, room_status";
/*used in Amend*/
amendableFields = "room_type, price, room_status";
requiredFields = "room_id, room_type, price, room_status";
/*End here*/

pageMode = "N,E,D";

%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px;  height: 150px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Room Details</legend>
    <div style="position:relative; z-index:0;">
        <div class="block" style="margin-left: 100px; top: 0px;">
            <label id="lb_room_id">Room ID</label>
            <input type="text" name="room_id" id="room_id" onkeypress='validate(event);' maxlength="4" style="width:50px;" onblur="LostFocus('LF_room_id()')">
        </div>
        <div class="block" style="margin-left: 100px; top: 30px;">
            <label id="lb_room_type">Room type</label>
            <select name="room_type" id="room_type">
            </select>
        </div>
        <div class="block" style="margin-left: 100px; top: 60px;">
            <label id="lb_price">Price</label>
            <input type="text" name="price" id="price" onkeypress='validate(event);' onblur="LostFocus('LF_price();')" maxlength="4" style="width:80px;">
        </div>
        <div class="block" style="margin-left: 100px; top: 90px;">
            <label id="lb_room_status">Room status</label>
            <select name="room_status" id="room_status">
            </select>
        </div>
    </div>
</fieldset>
<%@include file="hotel_room_details_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>