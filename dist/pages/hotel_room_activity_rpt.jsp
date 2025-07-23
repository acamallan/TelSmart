<%@include file="../header.jsp"%>

<fieldset style="width:1000px; height: 70px; margin: auto; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:2px; position: relative;"  >
    <legend>Filter</legend>
    
    <div class="block" style="margin-left: 0px; top: 10px;">
        <label>Date From</label>
        <input type="text" tabindex="2" id="date_from" style="width: 80px;" onblur="LostFocus('LF_date_from();')">
    </div>
    <div class="block" style="margin-left: 200px; top: 10px;">
        <label>Date To</label>
        <input type="text" tabindex="3" id="date_to" style="width: 80px;" onblur="LostFocus('LF_date_to();')">
    </div>
    <div class="block" style="margin-left:700px; top: 10px;">
       <input tabindex="4" type="button" value="Process" onclick="ProcessReport()">
    </div>
    <div class="block" style="margin-left:850px; top: 10px;">
       <input tabindex="5" type="button" value="Close" onclick="CancelReport()">
    </div>
</fieldset>
<div id="reportContent" style="width: 1000px; border: 1px solid #ddd; margin: auto; margin-top:20px;">
    <p style="font-size: 16px; font-weight: bold; text-align: center; margin-top: 20px;">Room Activity</p>
    <p>Date From: <span id="datefrom"></span></p>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;Date To: <span id="dateto"></span></p>
    
    
        <div class="component" style="width:100%; height:83%; float:left; padding:0px; overflow: auto; margin-top:0px;">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center;">Room Number</th>
                        <th style="text-align:center;">Room Type</th>
                        <th style="text-align:center;">Check-In</th>
                        <th style="text-align:center;">Check-Out</th>
                        <th style="text-align:center;">Guest Name</th>
                        <th style="text-align:center;">No. of Occupants</th>
                    </tr>
                </thead>
                <tbody>

                 </tbody>
            </table>
        </div>
    
</div>
<iframe id="my_iframe" style="display:none;"></iframe>
<%@include file="hotel_room_activity_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>