var stream = ""

$(document).ready(function(){
  stream = $('#imgContainer > img').attr("src");
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

// do the previous two things whenever the user resizes the window
$(window).resize(function(){
  expandImageContainer();
  centerImage();
});

var frequency = 2000;
var id = 0;

function beginLoop(){
  setInterval( "refreshImage()", frequency );
}

// same src, different id
function refreshImage(){
  $('#imgContainer > img').attr("src", stream + '?' + id);
  id++;
}

