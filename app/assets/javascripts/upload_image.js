$(function() {
  imgArray = []
  $('#s3-uploader').S3Uploader(
    {
      remove_completed_progress_bar: false,
      progress_bar_target: $('#uploads_container')
    }
  );
  $('#s3-uploader').bind('s3_upload_complete', function(e, content) {
    $("#uploads_container").append('<img src=' + content['url'] + ' height="125" width="125">')
    imgArray.push(content['url'] )
    $("#form_container").append('<input type="hidden" name="pic_url" value=' + imgArray + '>')
  });
});
