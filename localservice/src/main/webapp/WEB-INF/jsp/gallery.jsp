<%@include file="header.jsp" %>
      
  <div class="container generic-panel mar-t-20 pad-b-30">
	  <h3>Our Gallery</h3>
      <center>
      <div class="container mar-b-50">
        <iframe width="665" height="380" src="https://www.youtube.com/embed/tLUu-o0-LmI" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
      </div>   
      <hr> 
      <h4>Facilities and Surrounding</h4>
      <div class="container mar-t-20 mar-b-50">
        <c:forEach var="carImg" items="${carouselImages}" varStatus="loop">
          <img src="../../images/carousel/${carImg}" class="img-thumbnail carousel-image" style="width:320px;height:220px;margin:10px;" onclick="initPhotoswipe(${loop.index},'carousel-image');">
        </c:forEach>
      </div>  
      <hr>
      <h4>Rooms and Amenities</h4>
      <div class="container mar-t-20 mar-b-50">
        <c:forEach var="galImg" items="${galleryImages}" varStatus="loop">
          <img src="../../images/gallery/${galImg}" class="img-thumbnail gallery-image" style="width:320px;height:220px;margin:10px;" onclick="initPhotoswipe(${loop.index},'gallery-image');">
        </c:forEach>
      </div> 
    </center>             
  </div>  

<%@include file="photoswipe.jsp"%>
<%@include file="footer.jsp" %>