<%@include file="header.jsp" %>

  <div class="container generic-panel mar-t-20 pad-b-30">
    <h4>Contact Us</h4>
    <form action="contact-submit" class="form-horizontal mar-t-20" method="POST" id="formContact">
      <div class="form-group row">
        <label class="form-label col-md-3">*Full Name</label>
        <div class="col-md-9">
          <input type="text" class="form-control validate-alphabetic" name="fullName" maxlength="50" pattern="[a-zA-Z ]{2,50}" title="letters and space only (2-50 chars)" required>
        </div>
      </div>
      <div class="form-group row">
        <label class="form-label col-md-3">*Email</label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="email" placeholder="ex: user@gmail.com" maxlength="50" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="ex: user@gmail.com" required>
        </div>
      </div>
      <div class="form-group row">
        <label class="form-label col-md-3">Mobile Number</label>
        <div class="col-md-9">
          <input type="text" class="form-control validate-numeric-int" name="contactNumber" placeholder="ex: 09335558888" maxlength="11" pattern="09\d{9}" title="numbers only starting at 09 (11 digits)" required>
        </div>
      </div>
      <div class="form-group row">
        <label class="form-label col-md-3">*Message</label>
        <div class="col-md-9">
          <textarea rows="5" class="form-control" name="message" placeholder="Maximum of 500 characters" maxlength="500" required></textarea>
        </div>
      </div>  
      <div class="form-group row">
        <div class="col-md-3"></div>
        <div class="col-md-9">
          <label class="form-check-label"><input type="checkbox" class="form-check-input big-checkbox" id="chkNotRobot" />&nbsp;*I'm not a robot</label>
        </div>
      </div>   
      <div class="form-group row">
        <div class="col-md-12">
          <button type="submit" class="btn btn-primary pull-right mar-l-20 disabled" id="btnSubmitMessage" disabled>Submit <i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
          <a href="contact" class="btn btn-default pull-right">Clear <i class="fa fa-eraser" aria-hidden="true"></i></a>
        </div>
      </div>     
      <input type="hidden" id="messageSent" value="${messageSent}"> 
    </form>
  </div>

<%@include file="footer.jsp" %>