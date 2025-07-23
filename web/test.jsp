<%@include file="functions/was_function.jsp"%>
<%@include file="functions/classes.jsp"%>
<%
out.println(encryptJS("<tr><td style='text-align:left;'>Bourbon</td><td>1</td><td style='text-align:right;'>250.00</td></tr><br>"));
out.println(decryptJS("IdHIERmmPIj8kTesL6sdKRt13yeTVOLibk5vZ/3dHrIw/Wr9St0LeIQYho6Y4SImYXrNJbt1b5xcxOqb B1YGnY55ibNUEKLsix6tOtdKpPv3Fss9eN/gCJZSVE5pNAaE7GQ0M0eWIp5LC 92 NoNg=="));
					 //  IdHIERmmPIj8kTesL6sdKRt13yeTVOLibk5vZ/3dHrIw/Wr9St0LeIQYho6Y4SImYXrNJbt1b5xcxOqb B1YGnY55ibNUEKLsix6tOtdKpPv3Fss9eN/gCJZSVE5pNAaE7GQ0M0eWIp5LC 92 NoNg== 
%>
<html>
<head>
<script type="text/javascript" src="<%= baseURL()%>scripts/security.js"></script>

<script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/components/mode-ecb-min.js"></script>
<script>
    console.log(encryptJS("<tr><td style='text-align:left;'>Johnnie Walker</td><td>1</td><td style='text-align:right;'>250.00</td></tr>"));
	console.log(decryptJS("IdHIERmmPIj8kTesL6sdKRt13yeTVOLibk5vZ/3dHrJ3OSOLYUM5iwXALXMTBVIf8OJO6zUIovJZ82XcXX+aVgAZ7NkHoZ67gzZlaDTIcoYqHq/b7TIUlCbDl69aa7NCN1IF3ciKJC3OjuscGizALA=="));
	
</script>
</head>
<body>
</body>
</html>