function showMessage(type,message){
	$('div.alert-'+type).text(message);
	$('div.alert-'+type).show();
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
    $('input.datepicker').datepicker({
    	format: 'm/d/yyyy',
    	startDate: new Date()
    });
    $('#submitButtonFromHome').click(function(){
    	//return false;
    	//showMessage('warning','this is a warning');
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
    	window.print();
    	$(this).show();
    });
    
    $('div#myCarousel').carousel();
    $('table').excelTableFilter({
    	columnSelector: '.apply-filter'
    });

    paypal.Button.render({
        env: 'sandbox', // Or 'production',
        commit: true, // Show a 'Pay Now' button
        style: {
          color: 'gold',
          size: 'small'
        },
        payment: function(data, actions) {
          /* 
           * Set up the payment here 
           */
        },
        onAuthorize: function(data, actions) {
          /* 
           * Execute the payment here 
           */
        },
        onCancel: function(data, actions) {
          /* 
           * Buyer cancelled the payment 
           */
        },
        onError: function(err) {
          /* 
           * An error occurred during the transaction 
           */
        }
      }, '#paypal-button');
    
});