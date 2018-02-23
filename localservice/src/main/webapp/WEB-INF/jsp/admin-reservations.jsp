<%@include file="header-admin.jsp" %>

  <div class="container generic-panel mar-t-20 pad-b-30">
    <div class="row mar-b-20">
      <div class="col-md-6">
        <h4>${resToEdit == null ? 'Reservations' : 'Edit Reservation Status'}</h4>
      </div>
      <div class="col-md-6 text-right">
        <button class="btn btn-primary mar-r-10" id="btnPrintReservations">Print <i class="fa fa-print" aria-hidden="true"></i></button>
        <a href="admin-reservations" class="btn btn-primary" id="btnRefresh">Refresh <i class="fa fa-refresh" aria-hidden="true"></i></a>
      </div>
      <div class="container mar-t-20 ${resToEdit == null ? 'invisible' : ''}">
        <form action="admin-reservations-save" class="form-horizontal mar-t-20" method="POST">
          <div class="form-group row">
            <label class="form-label col-md-2">Reference ID</label>
            <div class="col-md-5">
              <input type="hidden" name="referenceId" value="${resToEdit.referenceId}">
              <input type="text" class="form-control disabled" value="${resToEdit.referenceId}" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">Main Guest</label>
            <div class="col-md-5">
              <input type="text" class="form-control disabled" value="${resToEdit.mainGuest.fullName}" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">Contact Number</label>
            <div class="col-md-5">
              <input type="text" class="form-control disabled" value="${resToEdit.mainGuest.contactNumber}" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">Total Pax</label>
            <div class="col-md-5">
              <input type="text" class="form-control disabled" value="${resToEdit.countAdult} adullt(s), ${resToEdit.countChildren} child(ren)" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">Check In</label>
            <div class="col-md-5">
              <input type="text" class="form-control disabled" value="<fmt:formatDate type="date" value="${resToEdit.checkIn}" />" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">Check Out</label>
            <div class="col-md-5">
              <input type="text" class="form-control disabled" value="<fmt:formatDate type="date" value="${resToEdit.checkOut}" />" disabled>
            </div>
          </div>
          <div class="form-group row">
            <label class="form-label col-md-2">*Status</label>
            <div class="col-md-5">
              <select class="form-control" name="status" value="${resToEdit.status}">
                <option value="PENDING" ${resToEdit.status == 'PENDING' ? 'selected' : ''}>PENDING</option>
                <option value="REJECTED" ${resToEdit.status == 'REJECTED' ? 'selected' : ''}>REJECTED</option>
                <option value="CONFIRMED" ${resToEdit.status == 'CONFIRMED' ? 'selected' : ''}>CONFIRMED</option>
                <%-- <option value="EXPIRED" ${resToEdit.status == 'EXPIRED' ? 'selected' : ''}>EXPIRED</option>
                <option value="CHECKED_OUT" ${resToEdit.status == 'CHECKED_OUT' ? 'selected' : ''}>CHECKED_OUT</option> --%>
              </select>
            </div>
          </div>                              
          <div class="form-group row">
            <div class="col-md-7">
              <button href="admin-reservations" class="btn btn-default pull-right mar-l-10">Cancel <i class="fa fa-eraser" aria-hidden="true"></i></button>
              <button type="submit" class="btn btn-primary pull-right">Save <i class="fa fa-floppy-o" aria-hidden="true"></i></button>                
            </div>
          </div>      
        </form>
      </div>
      <div class="container mar-t-20 ${resToEdit != null ? 'invisible' : ''}">
        <table class="table table-striped">
          <thead>
            <tr>
              <th class="apply-filter">REF ID</th>
              <th class="apply-filter">Main Guest</th>
              <th class="apply-filter">Contact</th>
              <th class="apply-filter">Check In</th>
              <th class="apply-filter">Check Out</th>
              <th class="apply-filter">Adult</th>   
              <th class="apply-filter">Child</th>
              <th class="apply-filter">Status</th>
              <th class="apply-filter">Amount</th>
              <th>&nbsp;</th>        
            </tr>
          </thead>
          <tbody>
            <c:forEach var="reservation" items="${reservationList}">
              <tr>
                <td>${reservation.referenceId}</td>
                <td>${reservation.mainGuest.lastName}, ${reservation.mainGuest.firstName}</td>
                <td>${reservation.mainGuest.contactNumber}</td>
                <td><fmt:formatDate type="date" value="${reservation.checkIn}" /></td>
                <td><fmt:formatDate type="date" value="${reservation.checkOut}" /></td>
                <td>${reservation.countAdult}</td>
                <td>${reservation.countChildren}</td>
                <td>${reservation.status}</td>
                <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${reservation.totalAmount}" /></td>  
                <td>
                  <c:if test="${reservation.status == 'PENDING'}">
                    <div class="text-center row">
                      <a href="admin-reservations-edit?referenceId=${reservation.referenceId}" class="pad-r-10 hidden-print" title="Edit"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                    </div>
                  </c:if>                                          
                </td>                             
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
    </div>    
  
  </div>

<%@include file="footer.jsp" %>