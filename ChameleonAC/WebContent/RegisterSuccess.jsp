
 
<html> 
<head>
	<title>Register Success</title>
</head>
 <body style="background-color:#2BD56F;">
 	<div style="border-radius: 30px;width:800px;overflow:hidden;background:#1AE66B;margin:0 auto;text-align:left;padding:0 2em;text-indent:2em;"> 
 		<font color="blue"><h1>
			<%out.println("welcome:"+request.getParameter("mac"));%>
		</h1></font>
    	 <font color="blue"><h1 >Register Success!!!</h1></font>
     	<font color="blue"><h1>Next Steps:</h1></font>
     	<UL>
     		<li><h1><strong>1.Disconnect the public connection</strong></h1></li>
     		<li><h1><strong>2.Connect the WiFi created for you(The password is what you have registered.)</strong></h1></li>
 	 	</UL>
 	 	<font color="blue"><h3>Enjoy your WiFi</h3></font>
 	</div>
 </body>
 </html>