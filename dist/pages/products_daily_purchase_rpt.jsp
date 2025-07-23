<%@include file="../header.jsp"%>

<fieldset style="width:500px; height: 200px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:2px;"  >
    <legend>Daily Purchase</legend>
    <div class="input-w" style="position: relative; margin-left:100px; margin-top: 30px;">
        <label id="lb_journal_id">Record date </label>
        <input type="text" name="record_date" id="record_date" placeholder='dd.mm.yyyy' onblur="checkDate(this)" style="width:80px; align:left;">
    </div>
    <div class="input-w" style="position: relative; margin-left:100px; margin-top: 50px;">
       <input type="button" name="process" id="process" value="Process" onclick="ProcessReport()">
    </div>
    <div class="input-w" style="position: relative; margin-left:250px; margin-top: -38px;">
       <input type="button" name="cancel" id="cancel" value="Cancel">
    </div>
</fieldset>
<%@include file="products_daily_purchase_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>