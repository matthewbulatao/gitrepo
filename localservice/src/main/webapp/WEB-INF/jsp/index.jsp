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
              <input data-provide="datepicker" data-date-format="m/d/yyyy" type="text" class="form-control" placeholder="Check-in" name="checkIn" />              
            </div>   
            <div class="col-md-3 inner-addon right-addon">
              <i class="fa fa-calendar icon-calendar" aria-hidden="true"></i>
              <input data-provide="datepicker" data-date-format="m/d/yyyy" type="text" class="form-control" placeholder="Check-out" name="checkOut" />              
            </div>         
            <div class="col-md-2 inner-addon right-addon">
              <i class="fa fa-plus-circle fa-second" aria-hidden="true" id="iconMath_add_Adult"></i>
              <i class="fa fa-minus-circle" aria-hidden="true" id="iconMath_minus_Adult"></i>
              <input type="text" class="form-control input-numeric" placeholder="Adult" name="countAdult" />              
            </div>
            <div class="col-md-2 inner-addon right-addon">
              <i class="fa fa-plus-circle fa-second" aria-hidden="true" id="iconMath_add_Children"></i>
              <i class="fa fa-minus-circle" aria-hidden="true" id="iconMath_minus_Children"></i>
              <input type="text" class="form-control input-numeric" placeholder="Child" name="countChildren" />              
            </div>
            <div class="col-md-2">
              <button class="btn btn-primary" type="submit">Search Rooms<i class="fa fa-search mar-l-5" aria-hidden="true"></i></button>
            </div>
          </form>
        </div>
      </div>
    </header>

    <section>
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-6 order-2">
            <div class="p-5">
              <img class="img-fluid rounded-circle" src="https://unsplash.it/500/500?image=836" alt="">
            </div>
          </div>
          <div class="col-md-6 order-1">
            <div class="p-5">
              <h2 class="display-4">For those about to rock...</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quod aliquid, mollitia odio veniam sit iste esse assumenda amet aperiam exercitationem, ea animi blanditiis recusandae! Ratione voluptatum molestiae adipisci, beatae obcaecati.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-6">
            <div class="p-5">
              <img class="img-fluid rounded-circle" src="https://unsplash.it/500/500?image=452" alt="">
            </div>
          </div>
          <div class="col-md-6">
            <div class="p-5">
              <h2 class="display-4">We salute you!</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quod aliquid, mollitia odio veniam sit iste esse assumenda amet aperiam exercitationem, ea animi blanditiis recusandae! Ratione voluptatum molestiae adipisci, beatae obcaecati.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section>
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-6 order-2">
            <div class="p-5">
              <img class="img-fluid rounded-circle" src="https://unsplash.it/500/500?image=453" alt="">
            </div>
          </div>
          <div class="col-md-6 order-1">
            <div class="p-5">
              <h2 class="display-4">Let there be rock!</h2>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quod aliquid, mollitia odio veniam sit iste esse assumenda amet aperiam exercitationem, ea animi blanditiis recusandae! Ratione voluptatum molestiae adipisci, beatae obcaecati.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

<%@include file="footer.jsp" %>