$(document).on('turbolinks:load', function() {
  $('.ckeditor:visible').each(function() {
    var id = $(this).attr('id');
    if (!CKEDITOR.instances[id]) {
       CKEDITOR.replace(id);
    }});
});
