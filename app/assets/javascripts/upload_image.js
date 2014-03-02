$(function() {
  $('#s3-uploader').S3Uploader(
    {
      remove_completed_progress_bar: false,
      progress_bar_target: $('#uploads_container')
    }
  );
  $('#s3-uploader').bind('s3_upload_complete', function(e, content) {
    $("#uploads_container").append('<img src=' + content['url'] + ' height="84" width="84">')
  });
});
