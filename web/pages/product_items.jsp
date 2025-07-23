<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
String product_id = "";
if(request.getParameter("link") != null && request.getParameter("product_id") != null){
    product_id = decrypt(request.getParameter("product_id"));
}
/* No need to put String as variables already initialize */
table = "was_product";
fields = "product_id as rowid, product_id, product_name, product_type, coa_type, category, supplier, note, barcode, reorder_quantity, reorder_threshold";
where = "product_id";

if(!product_id.equals("")){
    mainWhere = "product_id = '"+product_id+"'";
}
/*used in Add New*/
enableFields = "product_id, product_name, product_type, coa_type, category, supplier, note, reorder_quantity, reorder_threshold";
/*used in Amend*/
amendableFields = "product_type, coa_type, category, product_name, supplier, note, reorder_quantity, reorder_threshold";
requiredFields = "product_id, product_name, product_type, coa_type, category, supplier";

pageMode = "N,E,D";
/*End here*/

%>
<%@include file="../common/sidefind.jsp"%>

<div id="tabs" style="position:relative; z-index:0; width: 950px; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()"> Products Details</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" id="tab2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> Other Info </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" id="tab3" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab3()"> Transaction Details </a></li>
    </ul>
    <div id="tabs_1" style="height:660px;">
        <fieldset style="width:330px; height:340px; margin-left: 0px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Product Details</legend>
            <div class="block" style="margin-left: 0px; top: 20px; text-align: left;">
                <label  id="lb_product_id" style="text-align: right;">Product ID</label>
                <input type="text" name="product_id" id="product_id" style="width:80px;" onkeypress='validate(event);' maxlength="6">
            </div>
            <div class="block" style="margin-left: 0px; top: 50px;">
                <label id="lb_product_name">Product Name</label>
                <input type="text" name="product_name" id="product_name" maxlength="30">
            </div>
            <div class="block" style="margin-left: 0px; top: 80px;">
                <label id="lb_barcode">Barcode</label>
                <input type="text" name="barcode" id="barcode" maxlength="20">
            </div>
            <div class="block" style="margin-left: 0px; top: 110px;">
                <label id="lb_product_type">Product type</label>
                <select name="product_type" id="product_type">
                </select>
            </div>
            <div class="block" style="margin-left: 0px; top: 140px;">
                <label id="lb_coa_type">Inventory GL</label>
                <select name="coa_type" id="coa_type">
                </select>
            </div>
            <div class="block" style="margin-left: 0px; top: 170px;">
                <label id="lb_category">Category</label>
                <select name="category" id="category">
                </select>
            </div>
            <div class="block" style="margin-left: 0px; top: 200px;">
                <label id="lb_supplier">Supplier</label>
                <select name="supplier" id="supplier">
                </select>
            </div>
            <div class="block" style="margin-left: 0px; top: 230px;">
                <label id="lb_reorder_quantity">Reorder Qty</label>
                <input type="text" name="reorder_quantity" id="reorder_quantity" maxlength="6" style="width:50px;">
            </div>
            <div class="block" style="margin-left: -20px; top: 260px;">
                <label id="lb_reorder_threshold" style="width:120px;">Reorder Threshold</label>
                <input type="text" name="reorder_threshold" id="reorder_threshold" maxlength="6"  style="width:50px;">
            </div>
            <div class="block" style="margin-left: 0px; top: 290px; vertical-align: top;">
                <label id="lb_note" style="vertical-align: top; padding-top: 5px;">Notes</label>
                <textarea name="note" id="note" rows="2" cols="20" maxlength="100"></textarea>
            </div>
        </fieldset>
        
        <fieldset style="width:490px; height:340px; margin-top: 10px; margin-left: 390px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;">
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Price Information</legend>
            <div class="block" style="margin-left: -20px; top: 20px; text-align: left;">
                <label  id="lb_hd_cost_price" style="text-align: right; width: 160px; font-weight: bold;">Cost</label>
            </div>
            <div class="block" style="margin-left: -20px; top: 40px;">
                <label id="lb_hd_method">Method</label>
                <select name="hd_method" id="hd_method" style="width: 100px;">
                </select>
            </div>
            <div class="block" style="margin-left: -20px; top: 70px;">
                <label id="lb_hd_normal_price">Normal</label>
                <input type="text" name="hd_normal_price" id="hd_normal_price" maxlength="10"  style="width:80px;" onkeypress='validate(event);' onblur="formatDecimal(this);">
            </div>
            <div class="block" style="margin-left: -20px; top: 100px;">
                <label id="lb_hd_last_purch_price">Last Purch Price</label>
                <input type="text" name="hd_last_purch_price" id="hd_last_purch_price" maxlength="10"  style="width:80px;" onkeypress='validate(event);' onblur="formatDecimal(this);">
            </div>
            <div class="block" style="margin-left: -20px; top: 130px;">
                <label id="lb_hd_discount">Discount</label>
                <input type="text" name="hd_discount" id="hd_discount" maxlength="10"  style="width:80px;" onkeypress='validate(event);'>
            </div>
            <div class="block" style="margin-left: -20px; top: 160px;">
                <label id="lb_hd_cost_unit_measure">Unit Measure</label>
                <select name="hd_cost_unit_measure" id="hd_cost_unit_measure" style="width: 100px;">
                </select>
            </div>
            <div class="block" style="margin-left: -20px; top: 190px;">
                <label id="lb_hd_income_account">Cost GL</label>
                <select name="hd_cogs_account" id="hd_cogs_account" style="width: 180px;">
                </select>
            </div>
            <div class="block" style="margin-left: -20px; top: 220px;">
                <label id="lb_hd_tax_code">Tax Code</label>
                <input type="text" name="hd_average_cost" id="hd_average_cost" maxlength="4"  style="width:80px;" onkeypress='validate(event);'>
            </div>
            <div class="block" style="margin-left: -20px; top: 250px; vertical-align: top;">
                <label id="lb_hd_cost_description" style="vertical-align: top; padding-top: 5px;">Description</label>
                <textarea name="hd_cost_description" id="hd_cost_description" rows="2" cols=18" maxlength="100"></textarea>
            </div>
            
            <div class="block" style="margin-left: 220px; top: 20px; text-align: left;">
                <label  id="lb_hd_selling_price" style="text-align: right; width: 160px; font-weight: bold;">Selling</label>
            </div>
            <div class="block" style="margin-left: 220px; top: 40px;">
                <label id="lb_hd_srp">SRP</label>
                <input type="text" name="hd_srp" id="hd_srp" maxlength="10"  style="width:80px;" onkeypress='validate(event);' onblur="formatDecimal(this);">
            </div>
            <div class="block" style="margin-left: 220px; top: 70px;">
                <label id="lb_discounted">Discounted</label>
                <input type="text" name="hd_discounted" id="hd_discounted" maxlength="10"  style="width:80px;" onkeypress='validate(event);'>
            </div>
            <div class="block" style="margin-left: 220px; top: 100px;">
                <label id="lb_hd_wholesale">Wholesale</label>
                <input type="text" name="hd_wholesale" id="hd_wholesale" maxlength="10"  style="width:80px;" onkeypress='validate(event);'>
            </div>
            <div class="block" style="margin-left: 220px; top: 130px;">
                <label id="lb_hd_selling_unit_measure">Unit Measure</label>
                <select name="hd_selling_unit_measure" id="hd_selling_unit_measure" style="width: 100px;">
                </select>
            </div>
            <div class="block" style="margin-left: 220px; top: 160px;">
                <label id="lb_hd_income_account">Income GL</label>
                <select name="hd_income_account" id="hd_income_account" style="width: 180px;">
                </select>
            </div>
            <div class="block" style="margin-left: 220px; top: 190px;">
                <label id="lb_hd_tax_code">Tax Code</label>
                <input type="text" name="hd_tax_code" id="hd_tax_code" maxlength="6"  style="width:80px;" onkeypress='validate(event);'>
            </div>
            <div class="block" style="margin-left: 220px; top: 220px; vertical-align: top;">
                <label id="lb_hd_selling_description" style="vertical-align: top; padding-top: 5px;">Description</label>
                <textarea name="hd_selling_description" id="hd_selling_description" rows="2" cols=18"></textarea>
            </div>
            
            <div class="block" style="margin-left: 200px; top: 320px;">
                <input type="button" name="hd_actionPrice" id="hd_actionPrice" value="Add" style="width:100px;" onclick="AddPriceInfo()">
            </div>
        </fieldset>
        
        <fieldset style="width:500px; height:200px; margin-top: 410px; margin-left: 150px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;">
             <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Quantity on hand</legend>         
             <div style="width:94%; top: 20px; height:280px; position: absolute; overflow: auto;">
                <table>
                    <tbody>
                        <!--<tr>
                            <td style=" text-align:left; width: 50%; border:0px;">
                                <select name="hd_location" id="hd_location" onblur="GetLocTxtValue(this);">
                                </select>
                            </td>
                            <td style="text-align: center; width: 20%; border:0px;">
                                <input type="text" name="hd_quantity" id="hd_quantity" style="width:60px;">
                            </td>
                            <td style="text-align: center; width: 30%; border:0px;">
                                <input type="button" name="hd_action" id="hd_action" value="Add" style="width:100px;" onclick="AddLocation()">
                            </td>
                        </tr>
                        <tr>
                            <td style=" text-align:left; width: 50%; border:0px;">
                                <input type="button" name="hd_locationbtn" id="hd_locationbtn" value="Location" style="width:100px;" onclick="PopUpLocation()">
                            </td>
                        </tr> -->
                        <tr>
                            <td colspan="3" style="border:0px;">
                                <div style="overflow: auto; height: 150px; background-color: #f6f6f6; border: none;" class="component1">
                                <table style="padding: 0px;">
                                    <thead>
                                        <tr>
                                            <th style=" text-align:left; width: 50%">Location</th>
                                            <th style="text-align:center; width: 20%">Quantity</th>
                                            <!-- <th style="text-align:center; width: 30%">Action</th> -->
                                        </tr>
                                    </thead>
                                    <tbody id="prodLoc">
                                    </tbody>
                                </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" style="border: none; background-color: #f6f6f6;"> <br><br><b>Quantity: <span id="countQuantity"></span></b></td>
                        </tr>
                    </tbody>
                    
                </table>
                <input type="hidden" name="strCounter" id="strCounter" value="0">
                <input type="hidden" name="strLocTxtValue" id="strLocTxtValue" value="">
                <input type="hidden" name="strLocID" id="strLocID" value="">
        </fieldset>
    </div>
    <div id="tabs_2" style="height: 700px;">
        <fieldset style="width:880px; height:180px; margin-left: 0px; margin-top: 10px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Quantity on Purchase Order</legend>
            <div class="component1" style="width:94%; top: 20px; height:180px; position: absolute; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style=" text-align:center; width: 10%">Purchase ID</th>
                            <th style="text-align:center; width: 10%">Record Date</th>
                            <th style="text-align:center;">Supplier</th>
                            <th style="text-align:center; width: 10%">Quantity</th>
                            <th style=" text-align:center; width: 10%">Partial</th>
                            <th style=" text-align:center; width: 10%">Pending</th>
                        </tr>
                    </thead>
                    <tbody id="PODisplay">
                    </tbody>
                </table>
        </fieldset>
        <fieldset style="width:880px; height:180px; margin-left: 0px; margin-top: 240px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Vendor Information</legend>
            <div class="component1" style="width:94%; top: 20px; height:180px; position: absolute; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style=" text-align:center; width: 10%">Supplier</th>
                            <th style="text-align:center; width: 35%">Company Name</th>
                            <th style="text-align:center; width: 36%">Contact Person</th>
                            <th style="text-align:center; width: 10%">Price</th>
                            <th style=" text-align:center; width: 10%">Discount</th>
                        </tr>
                    </thead>
                    <tbody id="VendorDisplay">
                    </tbody>
                </table>
        </fieldset>
        
        <fieldset style="width:880px; height:170px; margin-left: 0px; margin-top: 470px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;"  >
            <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Materials/Components</legend>
            <div class="component1" style="width:94%; top: 20px; height:180px; position: absolute; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style=" text-align:left; width: 10%">Product ID</th>
                            <th style="text-align:center; width: 35%">Description</th>
                            <th style=" text-align:left; width: 36%">Quantity</th>
                            <th style="text-align:center; width: 10%">Cost</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="text-align: center;">
                                103456
                            </td>
                            <td style="text-align: left;">
                                Test Description
                            </td>
                            <td style="text-align: center;">
                                20  
                            </td>
                            <td style="text-align: center;">
                                150.00
                            </td>
                        </tr>
                    </tbody>
                </table>
        </fieldset>
    </div>
    <div id="tabs_3" style="height: 450px;">
        <fieldset style="width:880px; height:400px; margin-left: 0px; margin-top: 5px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px; z-index: 1; position: absolute;"  >
            <div class="component1" style="width:94%; top: 20px; height:380px; position: absolute; overflow: auto;">
                <table>
                    <thead>
                        <tr>
                            <th style="text-align:left; width: 12%">References</th>
                            <th style="text-align:center; width: 8%">Date</th>
                            <th style="text-align:left; width: 20%">Location</th>
                            <th style="text-align:center; width: 10%">IN</th>
                            <th style="text-align:center; width: 10%">OUT</th>
                            <th style="text-align:center; width: 10%">Total Quantity</th>
                            <th style="text-align:left; width: 10%">Amount</th>
                            <th style="text-align:left; width: 10%">Total Amount</th>
                            
                        </tr>
                    </thead>
                    <tbody id="TransDetailsDisplay">
                    </tbody>
                </table><br>
                <table>
                    <tr>
                        <td style="text-align:left; width: 12%; border: none;"></td>
                        <td style="text-align:center; width: 8%; border: none;"></td>
                        <td style="text-align:right; width: 15%; border: none; font-weight: bold;"> TOTAL</td>
                        <td style="text-align:center; width: 8%; border: none; font-weight: bold;" id="totalIN"></td>
                        <td style="text-align:center; width: 10%; border: none; font-weight: bold;" id="totalOUT"></td>
                        <td style="text-align:left; width: 10%; border: none;"></td>
                        <td style="text-align:left; width: 10%; border: none;"></td>
                        <td style="text-align:center; width: 10%; border: none; font-weight: bold;" id="transBalance"></td>
                    </tr>
                </table>
            </div>
        </fieldset>            
    </div>
</div>
            
<!-- Popup Location -->
<div id="dialog" title="Location" style="display: none; width: 400px;">
  <div class="block" style="margin-left: -20px; top: 30px;">
        <label id="lb_hd_supplier_id">Location ID</label>
        <input type="text" name="hd_location_id" id="hd_location_id" style="width:100px;" disabled>
    </div>
    <div class="block" style="margin-left: 200px; top: 30px;">
        <label id="lb_hd_company_name">Location Name</label>
        <input type="text" name="hd_location_name" id="hd_location_name" style="width:150px;" onblur="LF_company_name()">
    </div>
    <div class="block" style="margin-left: 500px; top: 25px;">
        <input type="button" name="hd_addLocInfo" id="hd_addLocInfo" value="Save" style="width:100px;" onclick="PopUpSaveLocation()">
    </div>
    <div style="height: 380px; border: 1px solid #F2F2F2; width: 98%; overflow: auto;  padding:5px; margin-left: 5px; top: 60px; position: relative;" class="component1">
        <table style="padding:0px;">
            <thead>
                <tr>
                    <th style=" text-align:center; width: 10%">ID</th>
                    <th style=" text-align:center; width: 60%">Location</th>
                    <th style=" text-align:center; width: 35%">Action</th>
                </tr>
            </thead>
            <tbody id="displayLocation">
            </tbody>
        </table>
        <input type="hidden" name="strCounterLoc" id="strCounterLoc" value="0">
    </div>
</div>
</fieldset>
<%@include file="product_items_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>