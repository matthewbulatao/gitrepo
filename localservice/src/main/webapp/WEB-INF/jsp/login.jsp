<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    
    <title>Casa Elum | Pavilion & Resort</title>

    <link href="../../vendor/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="../../css/one-page-wonder.css" rel="stylesheet">
	<link href="../../css/bootstrap-datepicker3.css" rel="stylesheet">
    <link href="../../css/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../css/style.css" rel="stylesheet">

  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">Casa Elum | Login</a>        
      </div>
    </nav>
    
    <%-- <c:if test="${loginError != null && loginError == true}">
      <div class="container text-center mar-t-20" style="width:32%">
        <div class="alert alert-danger">
          Login unsuccessful
        </div>
      </div>
    </c:if>  --%>   
    <input type="hidden" id="loginError" value="${loginError}" />
    
    <div class="container text-center card mar-t-100 wid-30">
      <form action="/login" method="POST" class="form-horizontal">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div class="form-group mar-t-20">
          <label class="control-label">User</label>
        </div>
        <div class="form-group">
          <center><input type="text" name="username" class="form-control text-center wid-80" required></center>
        </div>
        <div class="form-group">
          <label class="control-label">Password</label>
        </div>
        <div class="form-group">
          <center><input type="password" name="password" class="form-control text-center wid-80" required></center>
        </div>
        <div class="form-group mar-b-20">
          <button class="btn btn-default" type="submit">Sign In</button>  
        </div>         
      </form>
    </div>
    
    <script src="../../vendor/jquery/jquery.min.js"></script>
    <script src="../../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../../vendor/bootstrap-notify.js"></script>
    <script type="text/javascript">
        function showMessage(_type,_message){
        	$.notify(_message, {
        		type: _type,
        		placement: {
        			align: 'center'
        		},
        		offset: {
        			y: 60
        		}
        	});
        }
    	$(document).ready(function() {
    		if($('#loginError').val()){
    			showMessage('danger','<strong>Access denied</strong>, invalid credentials');
    		}
    	});
    </script>
  </body>

</html>