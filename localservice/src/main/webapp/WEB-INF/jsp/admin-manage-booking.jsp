<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>Manage Booking</h4>
  <hr>
  
  <div class="container row">
    <form class="form-horizontal col-md-12" action="admin-manage-booking-retrieve" method="GET">
      <div class="form-group row col-md-12">        
        <label class="control-label col-md-2 text-right">Reference ID</label>
        <input type="text" class="form-control col-md-2 validate-alphanumeric" name="referenceId" value="${savedBooking.referenceId}" maxlength="7" />
        <label class="control-label col-md-1 text-right">Email</label>
        <input type="text" class="form-control col-md-3" name="email" value="${savedBooking.mainGuest.email}" placeholder="ex: user@gmail.com" maxlength="50" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,3}$" title="ex: user@gmail.com"  />
        <button type="submit" class="btn btn-primary mar-l-20">Search <i class="fa fa-search" aria-hidden="true"></i></button> 
      </div>
    </form>
  </div>
  <div class="${(savedBooking == null && savedBookingList == null) ? 'invisible' : ''}">
    <table class="table table-striped">
      <thead>
        <tr>
          <c:if test="${savedBookingList != null}">
            <th>Reference ID</th>
          </c:if>
          <th>Main Guest</th>
          <th>Contact</th>
          <th>Check In</th>
          <th>Check Out</th>
          <th>Adult</th>   
          <th>Child</th>
          <th>Status</th>
          <th>Total Amount</th>       
        </tr>
      </thead>
      <tbody>          
        <c:if test="${savedBookingList != null}">              
          <c:forEach var="resBook" items="${savedBookingList}">
            <tr>
              <td><a href="admin-manage-booking-retrieve?referenceId=${resBook.referenceId}">${resBook.referenceId}</td>
              <td>${resBook.mainGuest.lastName}, ${resBook.mainGuest.firstName}</td>
              <td>${resBook.mainGuest.contactNumber}</td>
              <td><fmt:formatDate type="date" value="${resBook.checkIn}" /></td>
              <td><fmt:formatDate type="date" value="${resBook.checkOut}" /></td>
              <td>${resBook.countAdult}</td>
              <td>${resBook.countChildren}</td>
              <td>${resBook.status}</td>
              <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${resBook.totalAmount}" /></td>
            </tr>
          </c:forEach>
        </c:if>
        <c:if test="${savedBooking != null}">
          <tr>
            <td>${savedBooking.mainGuest.lastName}, ${savedBooking.mainGuest.firstName}</td>
            <td>${savedBooking.mainGuest.contactNumber}</td>
            <td><fmt:formatDate type="date" value="${savedBooking.checkIn}" /></td>
            <td><fmt:formatDate type="date" value="${savedBooking.checkOut}" /></td>
            <td>${savedBooking.countAdult}</td>
            <td>${savedBooking.countChildren}</td>
            <td style="color:${savedBooking.status == 'PENDING' || savedBooking.status == 'REJECTED' ? 'red' : (savedBooking.status == 'CONFIRMED' ? 'green' : '')};">${savedBooking.status}</td>
            <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${savedBooking.totalAmount}" /></td>
          </tr>
        </c:if>
      </tbody>
    </table>
  </div>
  
  <div id="accordion" role="tablist" class="${savedBooking == null ? 'invisible' : ''}">
    <div class="card">
      <div class="card-header" role="tab" id="headingOne"
        data-toggle="collapse" data-target="#collapseOne"
        data-parent="#accordion">
        <h5 class="mb-0">Extra Charges / Discounts</h5>          
      </div>        
      <div id="collapseOne" class="collapse ${savedBooking != null ? 'show' : ''}" role="tabpanel"
        aria-labelledby="headingOne" data-parent="#accordion">
        <div class="card-body">
          <div class="container mar-b-20 ${savedBooking.status != 'CONFIRMED' ? 'invisible' : ''}">
            <form action="admin-manage-booking-add-charge" method="POST">
              <input type="hidden" name="referenceId" value="${savedBooking.referenceId}"/>
              <input type="hidden" name="itemDescription" />
              <div class="form-group row col-md-12">
                <select class="for-control col-md-3" id="itemDescriptionAmenities">
                  <option value="">-select amenity-</option>
                  <c:forEach var="misc" items="${miscellaneousList}">
                    <option value="${misc.name}-SEPARATOR-${misc.rate}">${misc.name}</option>
                  </c:forEach>
                </select>
                <input type="text" class="form-control col-md-3 mar-l-20 validate-alphanumeric" id="itemDescriptionCustom" maxlength="25" placeholder="or put custom description here" />
                <label class="form-label col-md-1 text-right">Rate &#8369;</label>   
                <input type="number" class="form-control col-md-2" name="rate" id="rateCharge" step="0.10" required>
                <button type="submit" class="btn btn-primary mar-l-20" id="btnAddCharge">Add <span id="chargeOperation">Charge</span> <i class="fa fa-floppy-o" aria-hidden="true"></i></button> 
              </div>
            </form>
          </div>
          <div class="container">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th class="apply-filter">Item Description</th>
                  <th class="apply-filter">Rate</th>  
                  <th>&nbsp;</th>              
                </tr>
              </thead>
              <tbody>
                <c:forEach var="addCharge" items="${savedBooking.additionalCharges}">
                  <tr>
                    <td>${addCharge.itemDescription}</td>
                    <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${addCharge.rate}" /></td>
                    <td>
                      <form action="admin-manage-booking-delete-charge" method="POST">
                        <input type="hidden" name="referenceId" value="${savedBooking.referenceId}"/>
                        <input type="hidden" name="id" value="${addCharge.id}" />
                        <a href="#" title="Delete" class="delete-icon"><i class="fa fa-trash" aria-hidden="true"></i></a>
                      </form>                    
                    </td>               
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>            
        </div>
      </div>
    </div>
  </div>
  
  <div class="container mar-t-20 row ${savedBooking == null ? 'invisible' : ''}">
    <form action="admin-manage-booking-checkout" method="POST">
      <input type="hidden" name="referenceId" value="${savedBooking.referenceId}" />
      <button type="submit" id="btnCheckout" class="btn btn-primary ${savedBooking.status == 'CONFIRMED' ? '' : 'disabled'}" ${savedBooking.status == 'CONFIRMED' ? '' : 'disabled'}>Checkout <i class="fa fa-credit-card-alt" aria-hidden="true"></i></button>
    </form>     
    <a href="admin-manage-booking-summary?referenceId=${savedBooking.referenceId}" class="btn btn-primary mar-l-10" id="btnViewSummary">View Summary <i class="fa fa-list-ul" aria-hidden="true"></i></a>      
  </div>
  
  
</div>

<%@include file="footer.jsp"%>
