$(function() {
  imgArray = []
  var delete_max = $(".old_pic").length;

  $('#s3-uploader').S3Uploader(
    {
      remove_completed_progress_bar: false,
      progress_bar_target: $('#progress_container')
    }
  );

  $('#s3-uploader').bind('s3_upload_complete', function(e, content) {
    $("#uploads_container").append('<img style="padding-left: 5px;" class="remove_img" src=' + content['url'] + ' height="125" width="125">')
    imgArray.push(content['url'] )
    $("#rmv_msg").fadeIn("slow");
    $("#file-" + content['unique_id']).fadeOut(1000);
    $("#form_container").html('<input type="hidden" name="pic_url" value=' + imgArray + '>')
  });

  $('#s3-uploader').bind("s3_upload_failed", function(e, content) {
    $("#file-" + content['unique_id']).fadeOut(1000);
    console.log(e)
    alert('File "' + content["filename"] + '" failed to upload, must be smaller then 1MB and be of a .png or .jpg format')
  })

  $('#uploads_container').on('click', function() {
    if ($(event.target).hasClass('remove_img')) {
      var index = imgArray.indexOf($(event.target).attr('src'));
        imgArray.splice(index, 1)
      $(event.target).fadeOut("slow");
      $("#form_container").html('<input type="hidden" name="pic_url" value=' + imgArray + '>')
    }
  })

  $(".pic_validate").on("click", function(e) {
    if (imgArray.length === 0) {
      e.preventDefault();
      alert("You must upload at least 1 picture.");
    }
  });

  $(".old_pic").click(function() {
    var img_id = $(this).attr('name')
    if ( delete_max > 1 ) {
      delete_max --
      $('#' + img_id).fadeOut("slow");
      $.post( "/delete_pic", {id: img_id} )
    }
    else {
      alert("You must have at least 1 picture.")
    }
  })

});

