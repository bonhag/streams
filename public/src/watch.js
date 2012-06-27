$(document).ready(function(){
  expandImageContainer();
  centerImage();
  beginLoop();
});

// expand the image container vertically so it fills up the entire window
function expandImageContainer(){
  $('#imgContainer').height($(window).height());
}

// center image vertically and horizontally
function centerImage(){
  var container_height = $('#imgContainer').height();
  var container_width = $('#imgContainer').width();

  var image_height = $('#imgContainer > img').height();
  var image_width = $('#imgContainer > img').width(); 

  var image_bottom = (container_height - image_height) / 2;
  var image_left = (container_width - image_width) / 2;
  var image_right = image_left;
  var image_top = image_bottom;

  $('#imgContainer > img').css("bottom", image_bottom);
  $('#imgContainer > img').css("left", image_left);
  $('#imgContainer > img').css("right", image_right);
  $('#imgContainer > img').css("top", image_top);
}

var frequency = 2000

function beginLoop(){
  setInterval( "refreshImage()", frequency );
}

// same src, different timestamp
function refreshImage(){
  var source = $('#imgContainer > img').attr("src");
  var ms = new Date().getTime();
  $('#imgContainer > img').attr("src", source + '?' + ms);
}

