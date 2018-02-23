<%@include file="header.jsp" %>
<%@include file="hidden-booking-info.jsp" %>

<div class="container mar-t-20">
  <div class="container checkin-panel-booking ${CURRENT_SUBMODULE == 'step4' ? 'invisible' : ''}">
    <form class="row">            
      <div class="col-md-3">
        <label class="control-label">Check-In (<b><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${sessionScope.reservationDraft.checkIn}"/></b>)</label>
      </div>   
      <div class="col-md-3">
        <label class="control-label">Check-Out (<b><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${sessionScope.reservationDraft.checkOut}"/></b>)</label>
      </div>         
      <div class="col-md-3 text-right">
        <label class="control-label">Adult Count (<b>${sessionScope.reservationDraft.countAdult}</b>)</label>
      </div>
      <div class="col-md-3">
        <label class="control-label">Child Count (<b>${sessionScope.reservationDraft.countChildren}</b>)</label>
      </div>        
    </form>
  </div>
  
  <ol class="breadcrumb" id="stepsPanel">
    <li><a href="booking-step1" class="btn btn-default ${CURRENT_SUBMODULE == 'step1' ? 'booking-tab-active' : ''} ${CURRENT_SUBMODULE == 'step4' ? 'disabled' : ''}" id="btnSelectRoomsMenu"><span class="badge">1</span> Select Room</a><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><a href="booking-step2" class="btn btn-default ${CURRENT_SUBMODULE == 'step2' ? 'booking-tab-active' : ''} ${CURRENT_SUBMODULE == 'step1' || CURRENT_SUBMODULE == 'step4' ? 'disabled' : ''}"><span class="badge">2</span> Personal Details</a><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>
    <li><a href="#" class="btn btn-default disabled ${CURRENT_SUBMODULE == 'step3' ? 'booking-tab-active' : ''}"><span class="badge">3</span> Payment</a><i class="fa fa-chevron-right bc-separator" aria-hidden="true"></i></li>  
    <li><a href="#" class="btn btn-default disabled ${CURRENT_SUBMODULE == 'step4' ? 'booking-tab-active' : ''}"><span class="badge">4</span> Confirmation</a></li>        
  </ol>
  
  <!-- SELECT ROOMS -->
  <div class="${CURRENT_SUBMODULE != 'step1' ? 'invisible' : ''}">
    <form action="booking-step2" method="POST">
      
      <div class="list-group">
        <c:forEach var="room" items="${availableRooms}">
          <div class="list-group-item">
            <div class="media">
              <!-- <div class="media-left">
                <a href="#">
                  <img src="http://placehold.it/180x150" alt="" class="media-object">
                </a>
              </div> -->
              <div class="media-body mar-l-20">
                <h4 class="media-heading">${room.name}</h4>
                <input type="hidden" id="maxAdult_${room.id}" value="${room.capacity}" />
                <input type="hidden" id="maxChild_${room.id}" value="${room.capacityChildren}" />
                <span style="color:#14a9e7;">${room.type}</span>
                <p>                
                Max Adult: ${room.capacity} & Max Child: ${room.capacityChildren}<br>
                ${room.description}
                </p>  
                <c:if test="${room.conflicts != null}">
                  <ul>
                    <c:forEach var="conflict" items="${room.conflicts}">
                      <li style="color:red;"><i>${conflict}</i></li>
                    </c:forEach>
                  </ul>
                </c:if>              
              </div>
              <div class="media-right mar-l-20">
                <h4>&#8369; <fmt:formatNumber type="number" pattern="#,###" value="${room.rate}" /></h4>
                <c:if test="${room.conflicts == null}">
                  <label class="form-check-label"><input type="checkbox" class="form-check-input big-checkbox select-room-checkbox ${room.conflicts != null ? 'disabled' : ''}" name="selectedRoomIds" id="selectedRoomIds_${room.id}" value="${room.id}" />&nbsp;Select Room</label>
                </c:if>                
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
      <div class="col-md-12" style="margin-bottom:80px;">
        <button type="submit" class="btn btn-primary pull-right mar-t-20 mar-l-10" id="btnProceedToPersonal" style="margin-right:-15px;">Proceed <i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
        <a href="/" class="btn btn-primary pull-right mar-t-20 mar-r-10">Back to Home <i class="fa fa-undo" aria-hidden="true"></i></a>
      </div>
    </form>    
  </div>

  <!-- PERSONAL DETAILS -->
  <div class="${CURRENT_SUBMODULE != 'step2' ? 'invisible' : ''}">
    <form action="booking-step3" method="POST">
    
      <div class="container checkin-panel-booking">
        <h4>Personal Information</h4>
        <div class="form-horizontal mar-t-20">
          <div class="form-group row">
            <div class="col-md-1"></div>
            <label class="form-label col-md-2">*First Name</label>
            <div class="col-md-5">
              <input type="text" class="form-control validate-alphabetic" value="${reservationDraft.mainGuest.firstName}" name="firstName" maxlength="25" pattern="[a-zA-Z ]{2,25}" title="letters and space only (2-25 chars)" required>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-md-1"></div>
            <label class="form-label col-md-2">*Last Name</label>
            <div class="col-md-5">
              <input type="text" class="form-control validate-alphabetic" value="${reservationDraft.mainGuest.lastName}" name="lastName" maxlength="25" pattern="[a-zA-Z ]{2,25}" title="letters and space only (2-25 chars)" required>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-md-1"></div>
            <label class="form-label col-md-2">*Email</label>
            <div class="col-md-5">
              <input type="email" class="form-control" name="email" value="${reservationDraft.mainGuest.email}" placeholder="ex: user@gmail.com" maxlength="50" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="ex: user@gmail.com" required>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-md-1"></div>
            <label class="form-label col-md-2">*Mobile Number</label>
            <div class="col-md-5">
              <input type="text" class="form-control validate-numeric-int" name="contactNumber" value="${reservationDraft.mainGuest.contactNumber}" placeholder="ex: 09335558888" maxlength="11" pattern="09\d{9}" title="numbers only starting at 09 (11 digits)" required>
            </div>
          </div>          
        </div>
      </div>
      <div class="col-md-12" style="margin-bottom:80px;">
        <button type="submit" class="btn btn-primary pull-right mar-l-10 mar-t-20" style="margin-right:-15px;" id="btnValidatePersonal">Proceed to Payment <i class="fa fa-credit-card-alt" aria-hidden="true"></i></button>
        <a href="booking-step1" class="btn btn-primary pull-right mar-t-20 mar-r-10">Back to Rooms <i class="fa fa-undo" aria-hidden="true"></i></a>
      </div>            
    </form>    
  </div>
  
  <!-- PAYMENT -->
  <div class="${CURRENT_SUBMODULE != 'step3' ? 'invisible' : ''}">
    <form action="booking-step4" method="POST" id="formPayment">    
      
      <div class="container mar-t-20">
        <h4>Payment Method</h4>
      </div>      
      <div class="container checkin-panel-booking mar-t-10">        
        <div class="form-horizontal mar-t-20">
          <div class="form-group row">
            <input type="hidden" id="renderPaypal" value="${renderPaypal}"/> 
            <div class="col-md-6">
              <div class="col-md-12 row mar-b-20">
                <sec:authorize access="hasAnyRole('ADMIN','STAFF')">
                  <label class="radio-inline col-md-4"><input type="radio" id="rdoPayWalk" name="paymentMethod" value="WALK_IN"> Walk-In <i class="fa fa-male" aria-hidden="true"></i></label>
                </sec:authorize>
                <label class="radio-inline col-md-4"><input type="radio" id="rdoPayBank" name="paymentMethod" value="BANK_DEPOSIT"> Bank Deposit <i class="fa fa-university" aria-hidden="true"></i></label>
                <label class="radio-inline col-md-4"><input type="radio" id="rdoPayPal" name="paymentMethod" value="PAYPAL" checked> Paypal <i class="fa fa-paypal" aria-hidden="true"></i></label>
              </div>
              <hr>
              <div class="container">
                <span>
                  <sec:authorize access="hasAnyRole('ADMIN','STAFF')">
                    <b>For Walk-In</b>: Customer reservation will be CONFIRMED automatically upon payment over-the-counter
                    <br>
                  </sec:authorize>
                  <b>For Bank Deposit</b>: Bank details and instructions will be sent to you by email, 
                  your reservation will be on PENDING status until your payment is confirmed
                  <br>
                  <b>For PayPal</b>: Your reservation will be CONFIRMED upon successful payment transaction
                </span>
              </div>              
            </div>
            <input type="hidden" id="dpAmountForPaypal" value="${reservationDraft.dpAmount}"/>
            <div class="col-md-6">
              <span class="pull-right text-right" id="spanNonWalkin">
                Room(s) Rate = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.sumOfRoomRate}" />
                <br>
                x
                <br>
                Night(s) = ${reservationDraft.numOfNights}
                <br>
                <hr>
                <c:if test="${config.onlineBookingDiscount > 0}">
                  Room(s) Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.totalAmountRooms}" />
                  <br>
                  Online Discount = &#8369; (<fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.onlineBookingDiscount}" />)
                  <br>
                </c:if>
                Total Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.totalAmount}" />
                <br>                
                VAT (${config.vatPercentage}%) inclusive = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.vatAmount}" />
                <br>
                <hr>
                Reservation (${config.downPaymentPercentage}%) = <b>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.dpAmount}" /></b>
              </span>
              <span class="pull-right text-right invisible" id="spanWalkin">
                Room(s) Rate = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.sumOfRoomRate}" />
                <br>
                x
                <br>
                Night(s) = ${reservationDraft.numOfNights}
                <br>
                <hr>
                Room(s) Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationDraft.totalAmountRooms}" />
                <br>                
                VAT (${config.vatPercentage}%) inclusive = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${vatAmountWalkin}" />
                <br>
                <hr>
                Reservation (${config.downPaymentPercentage}%) = <b>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${dpAmountWalkin}" /></b>
              </span>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-12" style="margin-bottom:80px;">
        <div id="paypal-button" class="pull-right mar-l-10 mar-t-20"></div>
        <button type="submit" class="btn btn-primary pull-right mar-l-10 mar-t-20 invisible" style="margin-right:-15px;" id="btnProceedConfirm">Proceed to Confirmation <i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
        <a href="booking-step2" class="btn btn-primary pull-right mar-t-20 mar-r-10">Back to Personal Details <i class="fa fa-undo" aria-hidden="true"></i></a>
      </div>           
    </form>    
  </div>
  
  <div id="confirmationTab" class="${CURRENT_SUBMODULE != 'step4' ? 'invisible' : ''}">
    <div class="container checkin-panel-booking">
      <div class="row">
        <div class="col-md-12 hidden-print">
          <h4>Transaction Summary</h4>
        </div>        
      </div>    
      <div class="row">
        <div class="col-md-6 mar-t-20">
          <div>
            <span class="booking-summary-header">Schedule</span>
            <table class="table table-responsive">
              <tr>
                <td class="booking-summary-field">Check-in Date</td>
                <td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${reservationSubmitted.checkIn}" /></td>
              </tr>
              <tr>
                <td class="booking-summary-field">Check-out Date</td>
                <td><fmt:formatDate type="date" dateStyle="long" timeStyle="long" value="${reservationSubmitted.checkOut}" /></td>
              </tr>
            </table>
          </div>
          <div class="mar-t-20">
            <span class="booking-summary-header">Guests</span>
            <table class="table table-responsive">
              <tr>
                <td class="booking-summary-field">Main Guest</td>
                <td>${reservationSubmitted.mainGuest.fullName}</td>
              </tr>
              <tr>
                  <td class="booking-summary-field">Total Pax</td>
                  <td>${reservationSubmitted.countAdult} ${reservationSubmitted.countAdult > 0 ? 'adults' : 'adult'}, ${reservationSubmitted.countChildren} ${reservationSubmitted.countChildren > 0 ? 'children' : 'child'}</td>
              </tr>                  
            </table>
          </div>
          <div class="mar-t-20">
            <span class="booking-summary-header">Reserved Room(s)</span>
            <table class="table table-responsive">
              <c:forEach var="room" items="${reservationSubmitted.rooms}">
                <tr><td>${room.name}</td></tr> 
              </c:forEach>                             
            </table>
          </div>
        </div>
        <div class="col-md-6 mar-t-20">
          <span class="pull-right text-right">
            Booking Reference
            <br>
            <span id="bookingRefNumber">${reservationSubmitted.referenceId}</span>
            <br>
            Status
            <br>
            <span id="bookingStatus">${reservationSubmitted.status}</span>
            <br>
            Room(s) Rate = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.sumOfRoomRate}" />
            <br>
            x
            <br>
            Night(s) = ${reservationSubmitted.numOfNights}
            <br>
            <c:if test="${reservationSubmitted.onlineBookingDiscount > 0}">
              Room(s) Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.totalAmountRooms}" />
              <br>
              Online Discount = &#8369; (<fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.onlineBookingDiscount}" />)
              <br>
            </c:if>
            Total Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.totalAmount}" />
            <br>
            VAT (${config.vatPercentage}%) inclusive = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.vatAmount}" />
            <br>
            <hr>
            Reservation (${config.downPaymentPercentage}%) = <b>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.dpAmount}" /></b>
          </span>
        </div>
      </div>
      <c:if test="${reservationSubmitted.status == 'PENDING'}">
        <hr>
        <div class="container mar-b-20">
          <span>
            <strong>Important Instructions</strong>
            <br>
            &nbsp;1. Bank details for deposit transaction has been sent to your email, kindly check your email
            <br>
            &nbsp;2. Please deposit the exact amount <b>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationSubmitted.dpAmount}" /></b> within <b>${config.gracePeriodBankDepositHours} hours</b>
            <br>
            &nbsp;3. Send email to <b>${config.emailBankDeposit}</b> with subject <b>${reservationSubmitted.referenceId}</b> and <u>attach your DEPOSIT SLIP</u>
          </span>
        </div>
      </c:if>      
    </div>
    <div class="col-md-12" style="margin-bottom:80px;">
      <button class="btn btn-primary pull-right mar-l-10 mar-t-20 hidden-print" style="margin-right:-15px;" id="btnPrintBooking">Print Confirmation <i class="fa fa-print" aria-hidden="true"></i></button>
      <a href="/" class="btn btn-primary pull-right mar-t-20 mar-r-10 btnBackHome">Back to Home <i class="fa fa-undo" aria-hidden="true"></i></a>
    </div>
  </div>
  
</div>

<%@include file="footer.jsp" %>