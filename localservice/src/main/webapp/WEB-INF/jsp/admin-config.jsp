<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>System Properties</h4>
  <div class="container row mar-t-20">
    <form class="form-horizontal col-md-12" action="admin-config-save" method="POST">
      <input type="hidden" name="id" value="${config.id}">
      <div class="form-group row">     
        <label class="form-label col-md-4">Entrance Rate (Adult)</label>   
        <input type="number" class="form-control col-md-2" name="entranceFeeAdult" value="${config.entranceFeeAdult}" step="0.50" required>         
      </div>
      <div class="form-group row">     
        <label class="form-label col-md-4">Entrance Rate (Child)</label>   
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
        <button type="submit" class="btn btn-primary mar-l-10">Save <i class="fa fa-floppy-o" aria-hidden="true"></i></button>
      </div>
    </form>
  </div>  
  
  <input type="hidden" id="operationSuccess" value="${operationSuccess}">
</div>

<%@include file="footer.jsp"%>
