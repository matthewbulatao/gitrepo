<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>Rooms Management</h4>
  <div id="accordion" role="tablist">
    <div class="card">
      <div class="card-header" role="tab" id="headingOne"
        data-toggle="collapse" data-target="#collapseOne"
        data-parent="#accordion">
        <h5 class="mb-0">Manage</h5>
      </div>

      <div id="collapseOne" class="collapse" role="tabpanel"
        aria-labelledby="headingOne" data-parent="#accordion">
        <div class="card-body">
          <form action="${pageContext.request.contextPath}/admin/rooms/save" class="form-horizontal mar-t-20" method="POST">
            <input type="hidden" name="id" value="${room.id}">
            <div class="form-group row">
              <label class="form-label col-md-2">*Name</label>
              <div class="col-md-5">
                <input type="text" class="form-control" name="name" value="${room.name}">
              </div>
            </div>
            <div class="form-group row">
              <label class="form-label col-md-2">*Type</label>
              <div class="col-md-5">
                <select class="form-control" name="type" value="${room.type}">
                  <option value="STANDARD">Standard</option>
                  <option value="DELUXE">Deluxe</option>
                  <option value="SUITE">Suite</option>
                </select>
              </div>
            </div>
            <div class="form-group row">
              <label class="form-label col-md-2">*Capacity</label>
              <div class="col-md-5">
                <select class="form-control" name="capacity" value="${room.capacity}">
                  <c:forEach var="i" begin="1" end="20">
                    <option value="${i}">${i}</option>
                  </c:forEach>                  
                </select>
              </div>
            </div>
            <div class="form-group row">
              <label class="form-label col-md-2">*Rate (&#8369;)</label>
              <div class="col-md-5">
                <input type="text" class="form-control" name="rate" value="${room.rate}">
              </div>
            </div>  
            <div class="form-group row">
              <label class="form-label col-md-2">Description</label>
              <div class="col-md-5">
                <textarea rows="3" class="form-control" name="description" value="${room.description}"></textarea>
              </div>
            </div>  
            <div class="form-group row">
              <label class="form-label col-md-2">*Status</label>
              <div class="col-md-5">
                <select class="form-control" name="status" value="${room.status}">
                  <option value="A">Active</option>
                  <option value="I">Inactive</option>
                </select>
              </div>
            </div>                
            <div class="form-group row">
              <div class="col-md-7">
                <button href="#" class="btn btn-default pull-right mar-l-10">Clear <i class="fa fa-eraser" aria-hidden="true"></i></button>
                <button type="submit" class="btn btn-primary pull-right">Save <i class="fa fa-floppy-o" aria-hidden="true"></i></button>                
              </div>
            </div>      
          </form>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-header" role="tab" id="headingTwo"
        data-toggle="collapse" data-target="#collapseTwo"
        data-parent="#accordion">
        <h5 class="mb-0">List</h5>
      </div>
      <div id="collapseTwo" class="collapse show" role="tabpanel"
        aria-labelledby="headingTwo" data-parent="#accordion">        
        <div class="card-body">
          <table class="table table-striped">
            <thead>
              <tr>
                <th>Code</th>
                <th>Name</th>
                <th>Type</th>
                <th>Capacity</th>
                <th>Rate</th>
                <th>Status</th>              
                <th>&nbsp;</th> 
              </tr>
            </thead>
            <tbody>
              <c:forEach var="room" items="${roomList}">
                <tr>
                  <td>${room.code}</td>
                  <td>${room.name}</td>
                  <td>${room.type}</td>
                  <td>${room.capacity}</td>
                  <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.##" value="${room.rate}" /></td>
                  <td>${room.status}</td>   
                  <td>
                    <div class="text-center">
                      <a href="#" class="pad-r-10" title="View"><i class="fa fa-search" aria-hidden="true"></i></a>
                      <a href="#" class="pad-r-10" title="Edit"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                      <a href="#" title="Delete"><i class="fa fa-trash" aria-hidden="true"></i></a>
                    </div>                    
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

<%@include file="footer.jsp"%>
