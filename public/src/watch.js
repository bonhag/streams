$(document).ready(function(){
  expandImgContainer();
  beginLoop();
});

// expand the image container vertically so it fills up the entire window
function expandImgContainer(){
  $('#imgContainer').height($(window).height());
}

frequency = 2000

function beginLoop(){
  setInterval( "refreshImage()", frequency );
}

// same src, different timestamp
function refreshImage(){
  var source = $('#imgContainer > img').attr("src");
  var ms = new Date().getTime();
  $('#imgContainer > img').attr("src", source + '?' + ms);
}

