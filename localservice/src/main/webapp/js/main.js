$(document).ready(function() {
    $('.icon-calendar').click(function(){
    	$(this).next().datepicker().focus();    	
    });    
    $('i[id^=iconMath_]').click(function(){
    	let operation = $(this).attr('id').split('_')[1];
    	let type = $(this).attr('id').split('_')[2];
    	let value = parseInt($('input[name=count'+type+']').val());
    	$('input[name=count'+type+']').val(value>0 ? (operation == 'add' ? value+1 : value-1) : (operation == 'add' ? 1 : 0));
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
    
    $('div#myCarousel').carousel();
    $('table').excelTableFilter({
    	columnSelector: '.apply-filter'
    });

});