$(document).ready(function(){
  $("#avatarPopupLink").click(function(event){
    $("#avatarPopup").popup();
    event.preventDefault();
  });
});

function directUploadForm(formSelector, bucketUrl, s3Data){
  var fileIndex = 0;

  $(function() {
    $(formSelector).find("input:file").each(function(i, elem) {
      var fileInput    = $(elem);
      var form         = $(fileInput.parents('form:first'));
      var submitButton = form.find('input[type="submit"]');
      var progressBar  = $("<div class='bar'></div>");
      var barContainer = $("<div class='progress'></div>").append(progressBar);
      fileInput.after(barContainer);
      fileInput.fileupload({
        fileInput:        fileInput,
        url:              bucketUrl,
        type:             'POST',
        autoUpload:        false,
        singleFileUploads: true, 
        formData:          s3Data,
        paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
        dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
        replaceFileInput: false,
        add: function(e, data) {
          fileIndex++;
          var currentFile = fileIndex;

          submitButton.bind('click', function(event){
            if (currentFile == fileIndex) {
              data.submit();
            } else {
              data.pop;
            }
            event.preventDefault();
          });
        },
        progressall: function (e, data) {
          var progress = parseInt(data.loaded / data.total * 100, 10);
          progressBar.css('width', progress + '%')
        },
        start: function (e) {
          submitButton.prop('disabled', true);

          progressBar.
            css('background', 'green').
            css('display', 'block').
            css('width', '0%').
            text("Loading...");
        },
        done: function(e, data) {
          submitButton.prop('disabled', false);
          progressBar.text("Uploading done");

          // extract key and generate URL from response
          var key   = $(data.jqXHR.responseXML).find("Key").text();
          $("#user_avatar_url").val(key);
          form.submit();
        },
        fail: function(e, data) {
          submitButton.prop('disabled', false);

          progressBar.
            css("background", "red").
            text("Failed");
        }
      });
    });
  });
}