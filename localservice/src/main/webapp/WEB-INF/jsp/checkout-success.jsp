<%@include file="header-admin.jsp" %>

<div class="container mar-t-20">    
  <div>
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <c:set var="now" value="<%=new java.util.Date()%>" />
          <h4>${reservationToDisplay.status == 'CHECKED_OUT' ? 'Checkout' : 'Booking'} Summary <small>as of <fmt:formatDate type="both" dateStyle="medium" timeStyle="medium" value="${reservationToDisplay.status == 'CHECKED_OUT' ? reservationToDisplay.realCheckOut : now}" /></small></h4>
        </div>        
      </div>    
      <div class="container mar-t-20">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Reference ID</th>
              <th>Main Guest</th>
              <th>Contact</th>
              <th>Check In</th>
              <th>Check Out</th>
              <th>Total Pax</th>   
              <th>Status</th>                     
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><a href="admin-manage-booking-retrieve?referenceId=${reservationToDisplay.referenceId}">${reservationToDisplay.referenceId}</td>
              <td>${reservationToDisplay.mainGuest.lastName}, ${reservationToDisplay.mainGuest.firstName}</td>
              <td>${reservationToDisplay.mainGuest.contactNumber}</td>
              <td><fmt:formatDate type="date" value="${reservationToDisplay.checkIn}" /></td>
              <td><fmt:formatDate type="date" value="${reservationToDisplay.checkOut}" /></td>
              <td>Adult (${reservationToDisplay.countAdult}) <c:if test="${reservationToDisplay.countChildren > 0}">Child (${reservationToDisplay.countChildren})</c:if></td>
              <td style="color:${reservationToDisplay.status == 'PENDING' || reservationToDisplay.status == 'REJECTED' ? 'red' : (reservationToDisplay.status == 'CONFIRMED' ? 'green' : '')};">${reservationToDisplay.status}</td>              
            </tr>
          </tbody>
        </table>
      </div>
      
      <div class="container mar-t-50">
        <h5>Breakdown</h5>
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Item Description</th>
              <th class="text-right">Rate</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="addCharge" items="${itemsForDisplay}">
              <tr>
                <td>${addCharge.itemDescription}</td>
                <td class="text-right">&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${addCharge.rate}" /></td>                          
              </tr>
            </c:forEach>
          </tbody>
        </table>
        <hr>
        <div class="text-right">
          <span>
            Total Amount = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationToDisplay.totalAmount}" />
            <br>                
            VAT (${config.vatPercentage}%) inclusive = &#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationToDisplay.vatAmount}" />
            <br>
            Reservation (${config.downPaymentPercentage}%) = &#8369; (<fmt:formatNumber type="number" pattern="#,###.00" value="${reservationToDisplay.dpAmount}" />)
            <br>
            <hr>
            Balance = <b>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservationToDisplay.balanceUponCheckout}" /></b>
          </span>        
        <hr>
      </div>
    </div>
    <div class="col-md-12 container" style="margin-bottom:80px;">
      <button class="btn btn-primary pull-right mar-t-20 hidden-print" id="btnPrintBooking">Print Summary <i class="fa fa-print" aria-hidden="true"></i></button>
    </div>
  </div>
  
</div>

<%@include file="footer.jsp" %>