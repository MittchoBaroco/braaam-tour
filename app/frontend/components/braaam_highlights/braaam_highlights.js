import "./braaam_highlights.css";
import jQuery from "jquery";
import $ from "jquery";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import "slick-carousel/slick/slick.min.js";

$(document).ready(function(){
  $('.braaam-highlights--slider').slick({
    dots: true,
    arrows: true,
    infinite: false,
    autoplay: true,
    autoplaySpeed: 5000,
    speed: 1000
  });
});
