<%@include file="header.jsp" %>

    <header class="masthead">
      <div class="overlay">        
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
              <input type="number" min="1" max="${config.maxAdultPerBooking}" class="form-control input-numeric validate-numeric-int" placeholder="Adult" name="countAdult" value="${sessionScope.reservationDraft.countAdult}" required/>              
            </div>
            <div class="col-md-2">
              <input type="number" min="0" max="${config.maxChildrenPerBooking}" class="form-control input-numeric validate-numeric-int" placeholder="Child" name="countChildren" value="${sessionScope.reservationDraft.countChildren}" />              
            </div>
            <div class="col-md-2">
              <button class="btn btn-primary" type="submit" id="submitButtonFromHome">Search Rooms<i class="fa fa-search mar-l-5" aria-hidden="true"></i></button>
            </div>
          </form>
        </div>        
      </div>
    </header>    

<%@include file="footer.jsp" %>