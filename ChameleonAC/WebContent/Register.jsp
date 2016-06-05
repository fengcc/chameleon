
<!DOCTYPE html>

<html>
<head>
  <%
      String mac1="";
      mac1=request.getParameter("mac");
  %>
  <title>Register page</title>
 

  <link rel="stylesheet" media="all" href="./style/main.css" />
  <script src="./style/main.js"></script>

  
</head>
<body  style="background-color:#2BD56F;" class="login highrise" >
<div class="container">
  <div id="header">
    <h1><a class="logo">Basecamp</a></h1>
  </div>

  <div id="login_content" data-state="username" class="">
    <div id="login_content_inner">
      <div class="dialog_contents">

        <div id="login_dialog" class="login_dialog clearfix">

          <div class="form">
            <form onsubmit="Login.loginLoading()" action="RegisterCheck.jsp?mac=<%=mac1%>" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" />                          
              <div id="user_name_login">
            
                  <h1><strong>
                    <%
                    if(request.getParameter("MSG")==null){
                      out.println("Welcome!Please Register");

                    }else{
                      out.println(request.getParameter("MSG"));
                     
                    }%>
                  </strong></h1>
                  <h1><strong>
                    <%
                       out.print("mac:"+mac1);
                    %>
                  </strong></h1>
                <p style="">
                  <input type="text" name="id" id="id" value="" title="UserName" autocomplete="on" autocorrect="off" autocapitalize="off" class="overlayable" />
                </p>
                <p>
                  <input type="password" name="password1" id="password1" title="Password" autocomplete="on" autocorrect="off" autocapitalize="off" class="overlayable" />
                </p>
              </div>

              <div id="login_loading">
                  <h1>Signing in to <strong>Highrise</strong></h1>
              </div>

              <div id="signin_button">
                <input alt="Btn bc3 sign in@2x" type="image" src="./images/Register.jpg" />
              </div>
</form>
            <div class="loading" id="progressBar"></div>
          </div>
        </div>

  
      </div>
    </div>
  </div>

</div>

<script>

    $('id').focus();

</script>
</body>
</html>
