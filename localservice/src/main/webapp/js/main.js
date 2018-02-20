function showMessage(_type,_message){
	$.notify(_message, {
		type: _type,
		placement: {
			align: 'center'
		},
		offset: {
			y: 60
		}
	});
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
    $('#btnProceedToPayment').click(function(){
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
    $('#btnProceedConfirm').click(function(){
    	if($('input[name=email]').val()==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify your Email');
    		return false;
    	}
    	if($('input[name=firstName]').val()==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify your first name');
    		return false;
    	}
    	if($('input[name=lastName]').val()==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify your last name');
    		return false;
    	}
    	if($('input[name=contactNumber]').val()==""){
    		showMessage('danger','<strong>Sorry</strong>, please specify your contact number');
    		return false;
    	}
    });
    $('#btnPrintBooking').click(function(){
    	$('#stepsPanel').hide();
    	$(this).hide();
    	
    	window.print();
    	
    	$('#stepsPanel').show();
    	$(this).show();
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
    
    /*paypal.Button.render({
        env: 'sandbox', // Or 'production',
        commit: true, // Show a 'Pay Now' button
        style: {
          color: 'gold',
          size: 'small'
        },
        client: {
        	sandbox: 'SCC3BHU38BZNS'
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
        	return actions.payment.execute().then(function(payment) {
        		$('#formPayment').submit();
            });
        },
        onCancel: function(data, actions) {
           
           * Buyer cancelled the payment 
           
        },
        onError: function(err) {
           
           * An error occurred during the transaction 
           
        }
      }, '#paypal-button');*/
    
});