<%@include file="../header.jsp"%>

<fieldset style="width:700px; height: 440px; margin-left: 300px; margin-top: 20px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px; position: absolute;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Room Type Description</legend>
    <div class="block" style="margin-left: 100px; top: 30px;">
        <label id="lb_room_type">Room type</label>
        <select name="room_type" id="room_type" onChange="OC_room_type()">
        </select>
    </div>
    <div style="width:100%; height:300px; float:left; padding:0px; overflow: auto; margin-top:80px;">
        <table style="width: 80%;" align="center" border="0">
        <tbody id="displayList">
        </tbody>
    </table>
    <table style="width: 80%;" align="center" border="0">
        <tr style="background: none;">
            <td style="background-color: #f6f6f6; padding: 5px; width:80%" id="tdentry"></td>
        </tr>
    </table>
    </div>
    <div class="block" style="margin-left: 200px; top: 400px;">
        <input type="button" tabindex="7" name="btnNew" id="btnNew" value="New" style="width:100px;" onclick="New()">
        <input type="button" tabindex="8" name="btnSave" id="btnSave" value="Save" style="width:100px;" onclick="Save()">
        <input type="button" tabindex="9" name="btnClose" id="btnClose" value="Close" style="width:100px;" onclick="window.close();">
    </div>
    <input type="hidden" id="counter">
</fieldset>

<%@include file="hotel_room_type_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>