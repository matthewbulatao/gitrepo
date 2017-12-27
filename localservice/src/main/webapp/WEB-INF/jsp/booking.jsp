<%@include file="header.jsp" %>

<div class="container mar-t-20">
  <div class="container checkin-panel-booking">
    <form class="row">            
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-calendar" aria-hidden="true"></i>
        <input data-provide="datepicker" type="text" class="form-control" placeholder="Check-in" value="<fmt:formatDate pattern="M/d/yyyy" value="${sessionScope.reservationDraft.checkIn}"/>" />              
      </div>   
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-calendar" aria-hidden="true"></i>
        <input data-provide="datepicker" type="text" class="form-control" placeholder="Check-out" value="<fmt:formatDate pattern="M/d/yyyy" value="${sessionScope.reservationDraft.checkOut}"/>" />              
      </div>         
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-plus-circle fa-second" aria-hidden="true"></i>
        <i class="fa fa-minus-circle" aria-hidden="true"></i>
        <input type="text" class="form-control" placeholder="Adult" value="${sessionScope.reservationDraft.countAdult}" />              
      </div>
      <div class="col-md-3 inner-addon right-addon">
        <i class="fa fa-plus-circle fa-second" aria-hidden="true"></i>
        <i class="fa fa-minus-circle" aria-hidden="true"></i>
        <input type="text" class="form-control" placeholder="Child" value="${sessionScope.reservationDraft.countChildren}" />              
      </div>          
    </form>
  </div>

  <ol class="breadcrumb">
    <li><button class="btn btn-default <c:if test="${CURRENT_SUBMODULE == 'step1'}">booking-tab-active</c:if>" type="button"><span class="badge">1</span> Select Room</button><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><button class="btn btn-default <c:if test="${CURRENT_SUBMODULE == 'step2'}">booking-tab-active</c:if>" type="button"><span class="badge">2</span> Payment Details</button><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><button class="btn btn-default <c:if test="${CURRENT_SUBMODULE == 'step3'}">booking-tab-active</c:if>" type="button"><span class="badge">3</span> Confirmation</button></li>        
  </ol>
  
  <div id="selectRoomTab" class="<c:if test="${CURRENT_SUBMODULE != 'step1'}">invisible</c:if>">
    <div class="list-group">
      <c:forEach var="room" items="${availableRooms}">
        <div class="list-group-item">
          <div class="media">
            <div class="media-left">
              <a href="#">
                <img src="http://placehold.it/180x150" alt="" class="media-object">
              </a>
            </div>
            <div class="media-body mar-l-20">
              <h4 class="media-heading">${room.name}</h4>
              <p>${room.description}</p>
              <a href="#">See more details...</a>
            </div>
            <div class="media-right mar-l-20">
              <h4>&#8369; <fmt:formatNumber type="number" pattern="#,###" value="${room.rate}" /></h4>
              <button class="btn btn-primary">Select Room</button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
    <div class="col-md-12" style="margin-bottom:80px;">
      <a href="booking-step2" class="btn btn-primary pull-right mar-t-20" style="margin-right:-15px;">Proceed to Payment <i class="fa fa-credit-card-alt" aria-hidden="true"></i></a>
    </div>
  </div>

  <div id="paymentTab" class="<c:if test="${CURRENT_SUBMODULE != 'step2'}">invisible</c:if>">
    <div class="container checkin-panel-booking">
      <h4>Personal Information</h4>
      <form action="" class="form-horizontal mar-t-20">
        <div class="form-group row">
          <div class="col-md-1"></div>
          <label class="form-label col-md-2">*First Name</label>
          <div class="col-md-5">
            <input type="text" class="form-control">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-md-1"></div>
          <label class="form-label col-md-2">*Last Name</label>
          <div class="col-md-5">
            <input type="text" class="form-control">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-md-1"></div>
          <label class="form-label col-md-2">*Contact Number</label>
          <div class="col-md-5">
            <input type="text" class="form-control">
          </div>
        </div>
        <div class="form-group row">
          <div class="col-md-1"></div>
          <label class="form-label col-md-2">*Email</label>
          <div class="col-md-5">
            <input type="text" class="form-control">
          </div>
        </div>
      </form>
    </div>
    <div class="container checkin-panel-booking mar-t-20">
      <h4>Payment Method</h4>
      <form action="" class="form-horizontal mar-t-20">
        <div class="form-group row">
          <div class="col-md-3"></div>
          <label class="radio-inline col-md-2"><input type="radio" name="optradio" checked> Bank Deposit <i class="fa fa-university" aria-hidden="true"></i></label>
          <label class="radio-inline col-md-2"><input type="radio" name="optradio"> Paypal <i class="fa fa-paypal" aria-hidden="true"></i></label>
        </div>     
        <div class="form-group row">
          <div class="col-md-3"></div>
          <div class="col-md-5">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
          </div>
        </div>   
        <div class="form-group row">
          <div class="col-md-12">
            <a href="booking-step3" class="btn btn-primary pull-right mar-r-20">Proceed to Confirmation <i class="fa fa-paper-plane-o" aria-hidden="true"></i></a>
          </div>
        </div>    
      </form>
    </div>
  </div>
  
  <div id="confirmationTab" class="<c:if test="${CURRENT_SUBMODULE != 'step3'}">invisible</c:if>">
    <div class="container checkin-panel-booking">
      <div class="row">
        <div class="col-md-6">
          <h4>Transaction Summary</h4>
        </div>
        <div class="col-md-6">
          <span class="pull-right text-right">
            Booking Reference
            <br>
            <span id="bookingRefNumber">HBXYZ1</span>
            <br>
            Status
            <br>
            <span id="bookingStatus">CONFIRMED</span>
          </span>
        </div>
      </div>         
      <div class="col-md-12" style="margin-top:-50px !important;">
        <div>
          <span class="booking-summary-header">Schedule</span>
          <table class="table table-responsive">
            <tr>
              <td class="booking-summary-field">Check-in Date</td>
              <td>December 12, 2017</td>
            </tr>
            <tr>
              <td class="booking-summary-field">Check-out Date</td>
              <td>December 13, 2017</td>
            </tr>
          </table>
        </div>
        <div class="mar-t-20">
          <span class="booking-summary-header">Guests</span>
          <table class="table table-responsive">
            <tr>
              <td class="booking-summary-field">Main Guest</td>
              <td>John Dela Cruz</td>
            </tr>
            <tr>
                <td class="booking-summary-field">Total Pax</td>
                <td>2 adults, 1 child</td>
            </tr>                  
          </table>
        </div>
        <div class="mar-t-20">
          <span class="booking-summary-header">Rooms and Services</span>
          <table class="table table-responsive">
            <tr>
                <td>Room Name</td>
            </tr>                  
          </table>
        </div>
      </div> 
      <div class="col-md-12">
        <button class="btn btn-primary pull-right" style="margin-top:-50px;margin-right:-10px;">Print Confirmation <i class="fa fa-print" aria-hidden="true"></i></button>
      </div>
    </div>
  </div>
  
</div>

<%@include file="footer.jsp" %>