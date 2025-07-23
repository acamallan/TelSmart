<%@include file="../header.jsp"%>
<%@include file="../functions/record_function.jsp"%>

<%
/* No need to put String as variables already initialize */
table = "was_category";
fields = "was_id as rowid, was_id, category_name, category_description, parent_category";
where = "was_id";
/*used in Add New*/
enableFields = "category_name, category_description, parent_category";
/*used in Amend*/
amendableFields = "category_name, category_description, parent_category";
requiredFields = "category_name";

pageMode = "N,E,D";
/*End here*/
%>
<%@include file="../common/sidefind.jsp"%>

<fieldset style="width:700px; height: 150px; margin: auto; margin-top: 100px; border: 1px solid #ddd; background-color: #f6f6f6; padding:20px;"  >
    <legend style="font-size: 12px; font-weight: bold; padding:0 10px">Add Category</legend>
        <div style="position: relative;">
            <div class="block" style="margin-left: 100px; top: 0px;">
                <label id="lb_was_id">Category ID</label>
                <input type="text" name="was_id" id="was_id" style="width:200px;">
            </div>
            <div class="block" style="margin-left: 100px; top: 30px;">
                <label id="lb_category_name">Name</label>
                <input type="text" name="category_name" id="category_name" >
            </div>
            <div class="block" style="margin-left: 100px; top: 60px;">
                <label id="lb_parent_category">Category</label>
                <select name="parent_category" id="parent_category">
                </select>
            </div>
            <div class="block" style="margin-left: 80px; top: 90px; ">
                <label id="lb_category_description" style="width: 120px">Category Description</label>
                <input type="text" name="category_description"  id="category_description">
            </div>	
	</div>
</fieldset>

<%@include file="product_category_jsfunction.jsp"%>
<%@include file="../footer.jsp"%>