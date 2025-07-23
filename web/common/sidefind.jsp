<fieldset style="width:300px; height:500px; float:left; margin-top: 0px; border: 1px solid #ddd; background-color: #f6f6f6; padding:2px;" >
    <select name="hd_flrField" id="hd_flrField" style="background-color: #FFF; width: 170px;" onblur="checkFilterField()" tabindex="-1"></select>
    <input type="text" name="hd_flrValue" id="hd_flrValue" style="width:115px; margin-left: -5px;" onkeyup="Find(this.value)" tabindex="-1">
    <div id="displayFilter" style="padding:0px; height:430px;">
    </div>
    <div id="filterNav" class="filterNav" style="text-align: center">
        <button type="button" tabindex="-1" class="button" name="cmdfirst" onclick="first_page(); return false" title="First Page"> << </button>  
        <button type="button" tabindex="-1" class="button" name="cmdprev"  onclick="previous_page(); return false" title="Previous Page"> < </button> 
        <button type="button" tabindex="-1" class="button" name="cmdnext" onclick="next_page(); return false" title="Next Page"> > </button> 
        <button type="button" tabindex="-1" class="button" name="cmdlast" onclick="last_page(); return false" title="Last Page"> >> </button>
    </div>
</fieldset>