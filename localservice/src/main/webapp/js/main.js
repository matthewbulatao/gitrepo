function showMessage(_type,_message,_showProgressbar=false){
	$.notify(_message, {
		type: _type,
		placement: {
			align: 'center'
		},
		offset: {
			y: 60
		},
		showProgressbar: _showProgressbar
	});
}

function renderPaypalButton(){
	console.log('rendering paypal button...');
	$('#paypal-button').empty();
	paypal.Button.render({
        env: 'sandbox', // Or 'production',
        commit: true, // Show a 'Pay Now' button
        style: {
          color: 'gold',
          size: 'small'
        },
        client: {
        	sandbox: 'AdS_YcdMs815IKiinKsnzRKzIaIkSQrkwaUMWTdklbjCfhV8ultBNx1vXSltXtYLa2Jq0BrJBtGK5Qq4',
        	production: 'Adg8Nm4JiurJjBNVOCLSJXsUehmrcaTmnVSxauW5uC0llMUoN6LVHhTAyUIFi5PfUlgb3vcbhBlEsGVr'
        },
        payment: function(data, actions) {
        	return actions.payment.create({
                payment: {
                    transactions: [
                        {
                            amount: { total: $('#dpAmountForPaypal').val(), currency: 'PHP' }
                        }
                    ]
                }
            });        	
        },
        onAuthorize: function(data, actions) {
        	console.log('reservation payment authorized via paypal');
        	return actions.payment.execute().then(function(payment) {
        		console.log('proceeding to confirmation...');
        		$('#formPayment').submit();
            });
        },
        onCancel: function(data, actions) {
        	showMessage('warning','Paypal transaction cancelled');
        },
        onError: function(err) {
        	showMessage('danger','Paypal transaction error, check your account balance');
        }
      }, '#paypal-button');
}

$(document).ready(function() {
    $('.icon-calendar').click(function(){
    	$(this).next().datepicker().focus();    	
    });    
    $('i[id^=iconMath_]').click(function(){
    	let operation = $(this).attr('id').split('_')[1];
    	let type = $(this).attr('id').split('_')[2];
    	let value = parseInt($('input[name=count'+type+']').val());
    	$('input[name=count'+type+']').val((value>0 && !isNaN(value)) ? (operation == 'add' ? value+1 : value-1) : (operation == 'add' ? 1 : 0));
    });
    $('.delete-icon').click(function(){
    	if(confirm("Are you sure to delete?")){
    		$(this).closest('form').submit();
    	}
    });  
    $('#btnCheckout').click(function(){
    	if(confirm("Are you sure to checkout?")){
    		$(this).closest('form').submit();
    	}
    });
    $('input.datepicker').datepicker({
    	format: 'm/d/yyyy',
    	startDate: new Date()
    });
    $('input[name=checkIn]').change(function(){
    	var checkInDate = $(this).val();
    	var minCheckOut = moment(checkInDate, 'M/D/YYYY').add(1, 'days').format('M/D/YYYY');
    	$('input[name=checkOut]').datepicker('setStartDate', minCheckOut);
    });
    $('input[name=checkOut]').change(function(){
    	var checkOutDate = $(this).val();
    	var maxCheckIn = moment(checkOutDate, 'M/D/YYYY').subtract(1, 'days').format('M/D/YYYY');
    	$('input[name=checkIn]').datepicker('setStartDate', new Date());
    	$('input[name=checkIn]').datepicker('setEndDate', maxCheckIn);
    });   
    $('#submitButtonFromHome').click(function(){
    	var checkInDate = $('input[name=checkIn]').val();
    	var checkOutDate = $('input[name=checkOut]').val();
    	if(checkInDate==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify CHECK-IN date');
    		return false;
    	}
    	if(checkOutDate==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify CHECK-OUT date');
    		return false;
    	}
    	if(checkInDate >= checkOutDate){
    		showMessage('danger','<strong>Sorry</strong>, CHECK-IN must be before CHECK-OUT');
    		return false;
    	}
    	var countAdult = parseInt($('input[name=countAdult]').val());
    	var countChildren = parseInt($('input[name=countChildren]').val());
    	var maxAdult = $('input[name=countAdult]').attr('max');
    	var maxChild = $('input[name=countChildren]').attr('max');
    	if($('input[name=countAdult]').val()=="" || countAdult==0){
    		showMessage('danger','<strong>Sorry</strong>, please specify atleast 1 adult');
    		return false;
    	}
    	if(countAdult > maxAdult){
    		showMessage('danger','<strong>Sorry</strong>, maximum adult allowed is ' + maxAdult);
    		return false;
    	}
    	if(countChildren > maxChild){
    		showMessage('danger','<strong>Sorry</strong>, maximum children allowed is ' + maxChild);
    		return false;
    	}
    });   
    $('#btnProceedToPersonal').click(function(){
    	if($('input[name=selectedRoomIds]:checked').length == 0){
    		showMessage('danger','<strong>Sorry</strong>, please select atleast 1 room');
    		return false;
    	}
    	var countAdult = parseInt($('input[name=countAdult]').val());
    	var countChildren = parseInt($('input[name=countChildren]').val());
    	var capacityAdult = 0;
    	var capacityChild = 0;
    	$('input[name=selectedRoomIds]:checked').each(function(e){
    		var id = $(this).attr('value');
    		var roomAdult = parseInt($('#maxAdult_'+id).val());
    		var roomChild = parseInt($('#maxChild_'+id).val());
    		capacityAdult += roomAdult;
    		capacityChild += roomChild;    		
    	});
    	console.log('room adults: ' + capacityAdult + ', room children: ' + capacityChild);
    	console.log('input adults: ' + countAdult + ', input children: ' + countChildren);
    	var combinedTotal = countAdult + countChildren;
    	if(combinedTotal > capacityAdult){
    		var allowanceAdult = capacityAdult - countAdult;
    		if(allowanceAdult > 0){
    			var leftChildren = countChildren - allowanceAdult;
    			if(leftChildren > 0 && leftChildren > capacityChild){
    				showMessage('danger','<strong>Sorry</strong>, numberof children left ('+ leftChildren +') is greater than selected room capacity for children ('+ capacityChild +'), please select bigger room or multiple rooms to proceed');
            		return false;
    			}
    		}else if(allowanceAdult < 0){
    			showMessage('danger','<strong>Sorry</strong>, number of adults ('+ countAdult +') is greater than selected room capacity for adults ('+ capacityAdult +'), please select bigger room or multiple rooms to proceed');
        		return false;
    		}else if(allowanceAdult == 0 && countChildren > capacityChild){    			
        		showMessage('danger','<strong>Sorry</strong>, number of children ('+ countChildren +') is greater than selected room capacity for children ('+ capacityChild +'), please select bigger room or multiple rooms to proceed');
        		return false;            	
    		}   		
    	}    	
    });
    $('#btnValidatePersonal').click(function(){    	
    	if($('input[name=firstName]').val()!="" && $('input[name=firstName]').val().trim().length < 2){
    		showMessage('danger','<strong>Sorry</strong>, invalid first name format (alphabetic 2-25 chars)');
    		return false;
    	}
    	if($('input[name=lastName]').val()!="" && $('input[name=lastName]').val().trim().length < 2){
    		showMessage('danger','<strong>Sorry</strong>, invalid last name format (alphabetic 2-25 chars)');
    		return false;
    	}
    });
    
    $(".validate-alphabetic").limitkeypress({ rexp: /^[A-Za-z ]*$/ });
    $(".validate-alphanumeric").limitkeypress({ rexp: /^[A-Za-z0-9 ]*$/ });
    $(".validate-numeric-int").limitkeypress({ rexp: /^[0-9]*$/ });
    $(".validate-numeric-float").limitkeypress({ rexp: /^[0-9.]*$/ });
       
    $('input[name=password]').change(function(){
    	$(this).attr('maxlength','15');
    	$(this).attr('pattern','.{8,15}');
    	$(this).attr('title','password 8-15 characters long');
    	$('input[name=changedPassword]').val(true);
    });
    $('#btnPrintBooking').click(function(){
    	$('#stepsPanel').hide();
    	$(this).hide();
    	$('.btnBackHome').hide();
    	window.print();
    	
    	$('#stepsPanel').show();
    	$(this).show();
    	$('.btnBackHome').show();
    });
    $('#btnPrintReservations').click(function(){
    	$(this).hide(); 
    	$('#btnRefresh').hide();
    	$('.dropdown-filter-icon').hide();
    	window.print();
    	$(this).show();
    	$('.dropdown-filter-icon').show();
    	$('#btnRefresh').show();
    });
    
    $('div#myCarousel').carousel();
    $('table').excelTableFilter({
    	columnSelector: '.apply-filter'
    });
    $('#chkNotRobot').change(function(){
    	if(this.checked){
    		$('#btnSubmitMessage').removeClass('disabled');
    		$('#btnSubmitMessage').removeAttr('disabled');
    	}else{
    		$('#btnSubmitMessage').addClass('disabled');
    		$('#btnSubmitMessage').attr('disabled','disabled');
    	}
    });
    $('#formContact input[name=fullName]').val('');
    $('#formContact input[name=email]').val('');
    $('#formContact input[name=contactNumber]').val('');
    $('#formContact input[name=message]').val('');
    $('#formContact input#chkNotRobot').attr('checked',false);
    $('#formContact button#btnSubmitMessage').addClass('disabled');
	$('#formContact button#btnSubmitMessage').attr('disabled','disabled');
	
	if($('#messageSent').val()){
		showMessage('success','<strong>Thanks</strong>, your message has been sent successfully');
	}
	if($('#operationSuccess').val()){
		showMessage('success','<strong>Success</strong>, information successfully processed');
	}
    $('#rdoPayPal').change(function(){
    	if(this.checked){
    		$('#btnProceedConfirm').addClass('invisible');    
    		$('#paypal-button').removeClass('invisible'); 
    		$('#spanNonWalkin').removeClass('invisible'); 
    		$('#spanWalkin').addClass('invisible'); 
    		renderPaypalButton();    		
    	}
    });
    $('#rdoPayBank').change(function(){
    	if(this.checked){
    		$('#paypal-button').addClass('invisible');    		
    		$('#btnProceedConfirm').removeClass('invisible'); 
    		$('#spanNonWalkin').removeClass('invisible'); 
    		$('#spanWalkin').addClass('invisible'); 
    	}
    });
    $('#rdoPayWalk').change(function(){
    	if(this.checked){
    		$('#paypal-button').addClass('invisible');    		
    		$('#btnProceedConfirm').removeClass('invisible'); 
    		$('#spanNonWalkin').addClass('invisible'); 
    		$('#spanWalkin').removeClass('invisible'); 
    	}
    });
    if($('#renderPaypal').val()){
    	renderPaypalButton();
    } 
    $('#itemDescriptionAmenities').change(function(){
    	if($(this).val() != ''){
    		$('input[name=itemDescription]').val($(this).val().split('-SEPARATOR-')[0]);
        	$('input[name=rate]').val($(this).val().split('-SEPARATOR-')[1]);    		
    	}    	
    });
    $('input#itemDescriptionCustom').keyup(function(){
    	if($(this).val() != ''){
    		$('#itemDescriptionAmenities').val('');
    		$('input[name=itemDescription]').val($(this).val());
        	$('input[name=rate]').val('');
    	}    	
    });
    $('input#rateCharge').keyup(function(){
    	if($(this).val() < 0){
    		$('#chargeOperation').text('Discount');
    	}else{
    		$('#chargeOperation').text('Charge');
    	}    	
    });
    $('#btnAddCharge').click(function(){
    	if($('input[name=itemDescription]').val()==''){
    		showMessage('danger','<strong>Sorry</strong>, please choose an amenity or put custom description for the additional charges or discounts');
    		return false;
    	}
    });
    $('.select-room-checkbox').change(function(){
    	var chkBox = $(this);
    	var key = chkBox.val()+'-SEPARATOR-'+$('#checkInDraft').val()+'-SEPARATOR-'+$('#checkOutDraft').val(); 
    	var id = chkBox.attr('id');
    	if(this.checked){
    		$.ajax({
				url: "api/rooms/temporarily-reserve-room?key="+key, 
				success: function(result){
					if(result === 'ALREADY_RESERVED'){
						showMessage('danger','<strong>Sorry</strong>, this room is already booked at this moment<br>Refreshing rooms list...',true);
	    	        	$('#'+id).prop('checked',false);
	    	        	setTimeout(function(){ 
	    	        		window.location = 'booking-step1';
	    	        	}, 5000);	    	        	
					}else if(result !== 'OK'){
	    	        	showMessage('danger','<strong>Sorry</strong>, this room is temporarily blocked for booking, '+result);
	    	        	$('#'+id).prop('checked',false);
	    	        }
				}
    		});
    	}else{
    		$.ajax({
				url: "api/rooms/release-temporarily-reserve-room?key="+key
	    	});
    	}
    });
});