<%@include file="../header.jsp"%>

<fieldset style="width:250px; height:96%; float:left; margin-top: 1px; margin-left: 5px; border: 1px solid #ddd; background-color: #f6f6f6; padding:5px; position: relative;">
    <span style="font-weight: bold; padding-left: 90px;">Notifications</span><br>
    
    <span style="font-weight: bold;">Reorder Items</span><br>
    <div class="component1">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; ">Item Name</th>
                    <th style="text-align:center; width: 10%;">On Hand</th>
                </tr>
            </thead>
            <tbody id="reorder">
            </tbody>
        </table>
    </div>
    <input type="button" name="hd_PO" id="hd_PO" value="Purchase Order" style="width:100px;" onclick="PurchaseOrder()">
    <br><br>
    <span style="font-weight: bold;">No Movement Items</span><br>
    <div class="component1">
        <table>
            <thead>
                <tr>
                    <th style="text-align:center; ">Item Name</th>
                    <th style="text-align:center; width: 10%;">&nbsp;&nbsp;&nbsp;Days&nbsp;&nbsp;&nbsp;</th>
                </tr>
            </thead>
            <tbody id="noMovement">
            </tbody>
        </table>
    </div>
</fieldset>

<div id="tabs" style="position:relative; z-index:0; width: 77%; float: left; margin: 0px 5px 5px 5px;">
     <ul style="padding-left: 2px;">
        <li><a oncontextmenu="return false;" href="#tabs_1" style="padding:8px 20px; font-weight: bold; white-space: normal; vertical-align:middle;" onclick="tab1()"> With Quantity</a></li>
        <li><a oncontextmenu="return false;" href="#tabs_2" style="padding:8px 20px; font-weight: bold;" onclick="tab2()"> Without Quantity </a></li>
        <li><a oncontextmenu="return false;" href="#tabs_3" style="padding:8px 20px; font-weight: bold;" onclick="tab3()">Stock IN and OUT</a></li>
    </ul>
    <div id="tabs_1">
        <div class="component1" style="width:100%; height:100%; float:left; padding-left:5px; overflow: auto; position: relative;">
            &nbsp;Find: <input type="text" name="btnFind" id="btnFind" style="width:150px;" onkeyup="find_products(this.value)">
            <div class="block" style="margin-left:850px; top: -5px;">
                <input type="button" value="Close" name="done" id="done" onclick="window.close();">
            </div>
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center; width: 10%">Product ID</th>
                        <th style="text-align:center; ">Product Name</th>
                        <th style="text-align:center;">Category</th>
                        <th style="text-align:center; width: 10%">Cost Price</th>
                        <th style="text-align:center; width: 10%">Selling Price</th>
                        <th style="text-align:center; width: 5%">On Hand</th>
                        <th style="text-align:center; width: 5%">Action</th>
                    </tr>
                </thead>
                <tbody id="displayList">
                </tbody>
            </table>
        </div>
    </div>
    <div id="tabs_2">
        <div class="component1" style="width:100%; height:90%; float:left; padding-left:5px; overflow: auto;">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center; width: 10%">Product ID</th>
                        <th style="text-align:center; ">Product Name</th>
                        <th style="text-align:center;">Category</th>
                    </tr>
                </thead>
                <tbody id="displayListWO">
                </tbody>
            </table>
        </div>
    </div>
    <div id="tabs_3">
        <div class="component1" style="width:100%; height:90%; float:left; padding-left:5px; overflow: auto;">
            <table>
                <thead>
                    <tr>
                        <th style="text-align:center; width: 10%">Record Date</th>
                        <th style="text-align:center; width: 10%">Reference Number</th>
                        <th style="text-align:center; width: 10%">Product ID</th>
                        <th style="text-align:center; ">Product Name</th>
                        <th style="text-align:center; width: 10%">Stock IN</th>
                        <th style="text-align:center; width: 10%">Stock OUT</th>
                    </tr>
                </thead>
                <tbody id="displayListIO">
                </tbody>
            </table>
        </div>
    </div>
</div>
    

<!-- Popup -->
<div id="dialog" title="Product Information" class="component1" style="display: none;">
    <table style="padding: 0px;">
        <thead>
            <tr>
                <th style=" text-align:left; width: 50%">Location</th>
                <th style="text-align:center; width: 20%">Quantity</th>
            </tr>
        </thead>
        <tbody id="ProdView">
        </tbody>
    </table>
</div>

<%@include file="inventory_mngt_rpt_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>
