<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>System Properties</h4>
  <div class="container row mar-t-20">
    <form class="form-horizontal col-md-12" action="admin-config-save" method="POST">
      <input type="hidden" name="id" value="${config.id}">
      <div class="form-group row">     
        <label class="form-label col-md-4">Entrance Rate (Adult) &#8369;</label>   
        <input type="number" class="form-control col-md-2" name="entranceFeeAdult" value="${config.entranceFeeAdult}" step="0.50" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Entrance Rate (Child) &#8369;</label>   
        <input type="number" class="form-control col-md-2" name="entranceFeeChild" value="${config.entranceFeeChild}" step="0.50" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Maximum Guest per Booking (Adult)</label>   
        <input type="number" class="form-control col-md-2" name="maxAdultPerBooking" value="${config.maxAdultPerBooking}" min="1" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Maximum Guest per Booking (Child)</label>   
        <input type="number" class="form-control col-md-2" name="maxChildrenPerBooking" value="${config.maxChildrenPerBooking}" min="1" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Down Payment % to reserve</label>   
        <input type="number" class="form-control col-md-2" name="downPaymentPercentage" value="${config.downPaymentPercentage}" min="1" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">VAT %</label>   
        <input type="number" class="form-control col-md-2" name="vatPercentage" value="${config.vatPercentage}" min="1" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Online Booking Discount &#8369;</label>   
        <input type="number" class="form-control col-md-2" name="onlineBookingDiscount" value="${config.onlineBookingDiscount}" step="0.50" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Temporarily Reserve Room (Minutes)</label>   
        <input type="number" class="form-control col-md-2" name="tempReserveMinutes" value="${config.tempReserveMinutes}" min="1" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Bank Deposit Grace Period (Hours)</label>   
        <input type="number" class="form-control col-md-2" name="gracePeriodBankDepositHours" value="${config.gracePeriodBankDepositHours}" min="1" required>         
      </div>
      <hr>
      <div class="form-group row">     
        <label class="form-label col-md-4">Email to receive bank deposit slips</label>   
        <input type="text" class="form-control col-md-4" name="emailBankDeposit" value="${config.emailBankDeposit}" placeholder="ex: user@gmail.com" maxlength="50" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="ex: user@gmail.com" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Bank Name</label>   
        <input type="text" class="form-control col-md-4 validate-alphabetic" name="bank" value="${config.bank}" maxlength="25" pattern=".{3,25}" title="letters only up to 25 chars" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Account Number</label>   
        <input type="text" class="form-control col-md-4 validate-numeric" name="account" value="${config.account}" maxlength="25" pattern=".{3,25}" title="numbers only up to 25 chars" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Merchant Name</label>   
        <input type="text" class="form-control col-md-4 validate-alphanumeric" name="merchant" value="${config.merchant}" maxlength="50" pattern=".{3,50}" title="alphanumeric up to 50 chars" required>         
      </div>
      <hr>
      <div class="form-group row">
        <button type="submit" class="btn btn-primary mar-l-10">Save <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
      </div>
    </form>
  </div>  
  
  <input type="hidden" id="operationSuccess" value="${operationSuccess}">
</div>

<%@include file="footer.jsp"%>
