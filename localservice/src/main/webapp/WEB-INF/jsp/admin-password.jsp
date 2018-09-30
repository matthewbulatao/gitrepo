<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>Change Password</h4>
  <div class="container row mar-t-20">
	<form class="form-horizontal col-md-12" action="change-pwd" method="POST">
      <hr>
      <div class="form-group row">     
        <label class="form-label col-md-4">Old Password</label>   
        <input type="password" class="form-control col-md-4" name="oldPassword" pattern=".{5,12}" required title="5 to 12 characters">         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">New Password</label>   
        <input type="password" class="form-control col-md-4" name="newPassword" pattern=".{5,12}" required title="5 to 12 characters">         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Repeat New Password</label>   
        <input type="password" class="form-control col-md-4" name="repeatNewPassword" pattern=".{5,12}" required title="5 to 12 characters">         
      </div>
      <hr>
      <div class="form-group row">
        <button type="submit" class="btn btn-primary mar-l-10">Save <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
      </div>
    </form>
  </div>  
  
  <input type="hidden" id="operationSuccess" value="${operationSuccess}">
  <c:if test="${errorMessage != null}">
  	<input type="hidden" id="errorMessage" value="${errorMessage}">
  </c:if>
</div>

<%@include file="footer.jsp"%>
