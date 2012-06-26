// expand the image container vertically so it fills up the entire window
function expandImgContainer(){
  $('#imgContainer').height($(window).height());
}

$(document).ready(function(){
  expandImgContainer();
});

