// SETTING UP OUR POPUP
// 0 means disabled; 1 means enabled;
var popupStatus = 0;

// loading popup with jQuery magic!
function loadPopup(width, height, title, link) {
	// request data for centering
	var windowWidth = document.documentElement.clientWidth;
	var windowHeight = document.documentElement.clientHeight;
	// centering
	var x = window.innerWidth;
	var y = document.body.offsetHeight;
	jQuery(function($) {
		$("#popupContact").css({
			"height" : height,
			"width" : width,
			"position" : "absolute",
			"top" : (y/2)-(height/2),
			"left" : (windowWidth/2)-(width/2)
		});
	});
	// loads popup only if it is disabled
	if (popupStatus == 0) {
		showLoadingPanel();
		myAjax = new Ajax.Updater('popupContentDiv', link, {
			method : "post",
			onComplete : hideLoadingPanel,
			evalScripts : true
		});
		jQuery(function($) {
			$("#popupContact").fadeIn("slow");
			$("#popupHeaderDivConetent").html(title);
		});

		popupStatus = 1;
	}
}

// disabling popup with jQuery magic!
function disablePopup() {
	// disables popup only if it is enabled
	if (popupStatus == 1) {
		jQuery(function($) {
			$("#popupContact").fadeOut("slow");
			popupStatus = 0;
		});
	}
}





function openPopup(title, link, width, height) {
	loadPopup(width, height, title, link);
}
function closePopup() {
	disablePopup();
}


function hideLoadingPanel() {

}

function showLoadingPanel() {

}

