<%@include file="../header.jsp"%>

<script language="javascript" type="text/javascript">

    function SendValueToParent()

    {

        var myVal = document.getElementById('mytxt').value;

        window.opener.GetTransactionID(myVal);

        window.close();

        return false;

    }

</script>
Type text here and send it to parent window:

        <input id="mytxt" type="text" />

        <input type="button" id="btn1" value="Send Value to Parent" onclick="javascript:return SendValueToParent();" />

</body>

</html>