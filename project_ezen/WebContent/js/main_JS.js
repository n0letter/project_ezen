 function openCity(cityName, elmnt, color) {
	 
  // Hide all elements with class="tabcontent" by default */
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Remove the background color of all tablinks/buttons
  tablinks = document.getElementsByClassName("tablink");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].style.backgroundColor = "";
  }

  // Show the specific tab content
  document.getElementById(cityName).style.display = "block";

  // Add the specific color to the button used to open the tab content
  elmnt.style.backgroundColor = color;
  
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();

//쿠폰함
function myFunction() {
	
	var popup = document.getElementById("myPopup");
	popup.classList.toggle("show");
	
}

//back-to-top
$(document).ready(function(){
  $(window).scroll(function () {
    if ($(this).scrollTop() > 50) {
      console.log('fadeIn');
      $('#back-to-top').fadeIn();
    } else {
      console.log('fadeOut');
      $('#back-to-top').fadeOut();
    }
  });
  // scroll body to 0px on click
  $('#back-to-top').click(function () {
    console.log('click');
    $('#back-to-top').tooltip('hide');
    $('body,html').animate({
        scrollTop: 0
    }, 500);
    return false;
  });
  $('#back-to-top').tooltip('show');
});