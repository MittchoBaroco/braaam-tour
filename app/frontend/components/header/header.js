import "./header.css";
import jQuery from "jquery";
import $ from "jquery";

/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */

$( document ).ready(function() {
  $(".dropbtn-js").click(function(){
    $(".dropdown-js").toggleClass("show")
  })
});
