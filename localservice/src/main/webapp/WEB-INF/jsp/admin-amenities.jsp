<%@include file="header-admin.jsp"%>

<div class="container mar-t-20">
  <h4>Amenities Management</h4>  
  <div id="accordion" role="tablist">
    <div class="card">
      <div class="card-header" role="tab" id="headingOne"
        data-toggle="collapse" data-target="#collapseOne"
        data-parent="#accordion">
        <h5 class="mb-0">Manage</h5>
      </div>

      <div id="collapseOne" class="collapse <c:if test="${misc.id > 0}">show</c:if>" role="tabpanel"
        aria-labelledby="headingOne" data-parent="#accordion">
        <div class="card-body">
          <form action="admin-amenities-save" class="form-horizontal mar-t-20" method="POST">
            <input type="hidden" name="id" value="${misc.id}">
            <div class="form-group row">
              <label class="form-label col-md-2">*Name</label>
              <div class="col-md-5">
                <input type="text" class="form-control validate-alphanumeric" name="name" value="${misc.name}" maxlength="25" pattern="[a-zA-Z0-9 ]{2,25}" title="alphanumeric (2-25 chars)" required>
              </div>
            </div>            
            <div class="form-group row">
              <label class="form-label col-md-2">*Rate (&#8369;)</label>
              <div class="col-md-2">
                <input type="number" class="form-control" name="rate" value="${misc.rate}" step="0.50" required>
              </div>
            </div>  
            <div class="form-group row">
              <label class="form-label col-md-2">Description</label>
              <div class="col-md-5">
                <textarea rows="3" class="form-control" name="description" maxlength="250" required>${misc.description}</textarea>
              </div>
            </div>  
            <div class="form-group row">
              <div class="col-md-7">
                <a href="admin-amenities" class="btn btn-default pull-right mar-l-10">Cancel <i class="fa fa-eraser" aria-hidden="true"></i></a>
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
      <div id="collapseTwo" class="collapse <c:if test="${misc == null}">show</c:if>" role="tabpanel"
        aria-labelledby="headingTwo" data-parent="#accordion">        
        <div class="card-body">
          <table class="table table-striped">
            <thead>
              <tr>
                <th class="apply-filter">Code</th>
                <th class="apply-filter">Name</th>
                <th class="apply-filter">Rate</th>  
                <th>&nbsp;</th>              
              </tr>
            </thead>
            <tbody>
              <c:forEach var="miscellaneous" items="${miscellaneousList}">
                <tr>
                  <td>${miscellaneous.code}</td>
                  <td>${miscellaneous.name}</td>
                  <td>&#8369; <fmt:formatNumber type="number" pattern="#,###.00" value="${miscellaneous.rate}" /></td>
                  <td>
                    <div class="text-center row">
                      <a href="admin-amenities-edit?code=${miscellaneous.code}" class="pad-r-10" title="Edit"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                      <form action="admin-amenities-delete" method="POST">
                        <input type="hidden" name="code" value="${miscellaneous.code}" />
                        <a href="#" title="Delete" class="delete-icon"><i class="fa fa-trash" aria-hidden="true"></i></a>
                      </form>                      
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
