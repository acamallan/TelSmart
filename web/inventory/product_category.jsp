<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "wasi_cs_product_category";
fields = "product_category_id as rowid, product_category_id, product_category_name, product_category_description";
where = "product_category_id";
/*used in Add New*/
enableFields = "product_category_id, product_category_name, product_category_description";
/*used in Amend*/
amendableFields = "product_category_name, product_category_description";
requiredFields = "product_category_id, product_category_name";
/*End here*/
%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 14px; font-weight: bold; padding:0 10px">Add Category</legend>
        <form action="" method="post" name="wasForm" id="wasForm" autocomplete="off">
            <div class="input-w" style="margin-left: 100px; margin-top: 0px;">
                <label for="#your-input" id="lb_product_category_id">Category ID</label>
                <input type="text" name="product_category_id" id="product_category_id" required onkeypress='validate(event);' maxlength="3" style="width:50px;" onblur="CheckProductCategoryID(this.value); leadingzero(this.id,this.value,'3');">
            </div>
            <div class="input-w" style="margin-left: 78px;">
                <label for="#your-input" id="lb_product_category_name">Category Name</label>
                <input type="text" name="product_category_name" id="product_category_name"  required >
            </div>
            <div class="input-w" style="margin-left: 51px;">
                <label for="#your-input" id="lb_product_category_description">Category Description</label>
                <input type="text" name="product_category_description"  id="product_category_description" required>
            </div>	
	</form>
</fieldset>

<%@include file="product_category_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>