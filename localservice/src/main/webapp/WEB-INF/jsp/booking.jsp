<%@include file="header.jsp" %>

<div class="container mar-t-20">
  <div class="container checkin-panel-booking">
    <form class="row">            
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-calendar" aria-hidden="true"></i>
        <input data-provide="datepicker" type="text" class="form-control" placeholder="Check-in" />              
      </div>   
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-calendar" aria-hidden="true"></i>
        <input data-provide="datepicker" type="text" class="form-control" placeholder="Check-out" />              
      </div>         
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-plus-circle fa-second" aria-hidden="true"></i>
        <i class="fa fa-minus-circle" aria-hidden="true"></i>
        <input type="text" class="form-control" placeholder="Adult" />              
      </div>
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-plus-circle fa-second" aria-hidden="true"></i>
        <i class="fa fa-minus-circle" aria-hidden="true"></i>
        <input type="text" class="form-control" placeholder="Child" />              
      </div>          
    </form>
  </div>

  <ol class="breadcrumb">
    <li><button class="btn btn-default" type="button"><span class="badge">1</span> Select Room</button><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><button class="btn btn-default" type="button"><span class="badge">2</span> Payment Details</button><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><button class="btn btn-default" type="button"><span class="badge">3</span> Confirmation</button></li>        
  </ol>

  <div class="container row">
    
  </div>
</div>

<%@include file="footer.jsp" %>