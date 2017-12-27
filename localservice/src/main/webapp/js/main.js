function activateCurrentModule(){
	$.ajax({
		url: '/api/common/get-current-module',
		success: function(data){
			$('#mainMenuNav li.active').removeClass('active');
			if(data === ''){
				$('#menu_home').addClass('active');
			}else{
				$('#menu_'+data).addClass('active');
			}
		}
	});
}

$(document).ready(function() {
    $('.datepicker').datepicker({
        autoclose: true
    });
    
//    activateCurrentModule();
});