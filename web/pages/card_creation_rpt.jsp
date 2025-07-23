<%@include file="../header.jsp"%>

<fieldset style="width:450px; height: 200px; margin-left: 20px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px; position: absolute;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Generate Card Number</legend>
    <div style="position: relative;">
        <div class="block" style="margin-left: 50px; top: 0px;">
            <label id="lb_branch">Branch</label>
            <select tabindex="1" name="branch" id="branch" onblur="LostFocus('LF_branch()')">
            </select>
            <input type="text" tabindex="-1" name="branch_id" id="branch_id" style="width: 50px;">
        </div>
        <div class="block" style="margin-left: 50px; top: 30px;">
            <label id="lb_card_type">Card type</label>
            <select tabindex="2" name="card_type" id="card_type" onblur="LostFocus('LF_card_type()')">
            </select>
            <input type="text" tabindex="-1" name="card_type_id" id="card_type_id" style="width: 50px;">
        </div>
        <div class="block" style="margin-left: 50px; top: 60px;">
            <label id="lb_record_date">Record Date</label>
            <input type="text" tabindex="3" name="record_date" id="record_date" style="width: 80px;" onkeypress='validate(event);' onblur="LostFocus('LF_record_date(); ')">
        </div>
        <div class="block" style="margin-left: 50px; top: 90px;">
            <label id="lb_no_of_entries">Number of Entries</label>
            <input type="text" tabindex="4" name="no_of_entries" id="no_of_entries" style="width: 80px;" onblur="LostFocus('LF_no_of_entries()')" onkeypress='validate(event);' maxlength="4">
        </div>
        <div class="block" style="margin-left: 0px; top: 120px;">
            <label id="lb_expiry_threshold" style="width: 150px;">Expiry Threshold(months)</label>
            <input type="text" tabindex="5" name="expiry_threshold" id="expiry_threshold" style="width: 80px;" onblur="LostFocus('LF_expiry_threshold()')" onkeypress='validate(event);' maxlength="2">
        </div>
        <div class="block" style="margin-left: 230px; top: 120px;">
            <label id="lb_expiry_date" >Expiry Date</label>
            <input type="text" tabindex="-1" name="expiry_date" id="expiry_date" style="width: 80px;">
        </div>
        <div class="block" style="margin-left: 100px; top: 150px;">
            <input type="button" tabindex="6" name="btnGenerate" id="btnGenerate" value="Generate" style="width:100px;" onclick="Generate()">
            <input type="button" tabindex="7" name="btnClose" id="btnClose" value="Close" style="width:100px;" onclick="window.close();">
        </div>
    </div>
</fieldset>
<fieldset style="width:700px; height: 500px; margin-left: 510px; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:10px; position: absolute;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Generated Card Numbers</legend>
    <div class="component1" style="width:100%; height:420px; float:left; padding:0px; overflow: auto; margin-top:10px;">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; width: 20%">Card Number</th>
                    <th style="text-align:center; width: 30%">Record Date</th>
                    <th style="text-align:center; width: 20%">Expiry Date</th>
                    <th style="text-align:center; width: 20%">Status</th>
                    <th style="text-align:center; width: 20%">Link Number</th>
                </tr>
            </thead>
            <tbody id="displayList">
            </tbody>
        </table>
    </div>
    <div class="block" style="margin-left: 0px; top: 460px;">
        <span style="font-weight: bold;">Total Cards Generated:</span> <span style="font-weight: bold; color: red;" id="total"></span>
    </div>
        
</fieldset>
<%@include file="card_creation_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>