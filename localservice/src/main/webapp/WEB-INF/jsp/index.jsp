<%@include file="header.jsp" %>

    <header class="masthead">
      <div class="overlay">   
        <c:if test="${config.onlineBookingDiscount > 0}">
          <div class="container">
            <a href="#" class="btn btn-default booking-tab-active pull-left disabled" style="background-color:#faffb0;margin-top:-70px;font-size:14pt;">Enjoy <b>&#8369; <fmt:formatNumber type="number" pattern="#,###" value="${config.onlineBookingDiscount}" /> off</b> when you book online!</a>
          </div>
        </c:if>
        <div class="container">
          <h1 class="display-1 text-white">Casa Elum</h1>
          <h2 class="display-4 text-white">Pavilion & Resort</h2>
        </div>
        <div class="container mar-t-50 wid-70 checkin-panel">
          <form class="col-md-12 row" action="booking-step1" method="POST">            
            <div class="col-md-3 inner-addon right-addon">
              <i class="fa fa-calendar icon-calendar" aria-hidden="true"></i>
              <input type="text" class="form-control datepicker" placeholder="Check-in" name="checkIn" value="<fmt:formatDate pattern="M/d/yyyy" value="${sessionScope.reservationDraft.checkIn}"/>" readonly/>              
            </div>   
            <div class="col-md-3 inner-addon right-addon">
              <i class="fa fa-calendar icon-calendar" aria-hidden="true"></i>
              <input type="text" class="form-control datepicker" placeholder="Check-out" name="checkOut" value="<fmt:formatDate pattern="M/d/yyyy" value="${sessionScope.reservationDraft.checkOut}"/>" readonly/>              
            </div>         
            <div class="col-md-2">
              <input type="number" min="1" max="${config.maxAdultPerBooking}" class="form-control input-numeric" placeholder="Adult" name="countAdult" value="${sessionScope.reservationDraft.countAdult}" required/>              
            </div>
            <div class="col-md-2">
              <input type="number" min="0" max="${config.maxChildrenPerBooking}" class="form-control input-numeric" placeholder="Child" name="countChildren" value="${sessionScope.reservationDraft.countChildren}" />              
            </div>
            <div class="col-md-2">
              <button class="btn btn-primary" type="submit" id="submitButtonFromHome">Search Rooms<i class="fa fa-search mar-l-5" aria-hidden="true"></i></button>
            </div>
          </form>
        </div>        
      </div>
    </header>    

<%@include file="footer.jsp" %>