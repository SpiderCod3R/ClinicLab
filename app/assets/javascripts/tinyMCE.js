tinyMCE.init({
  selector: 'textarea.editor',
  theme_url: (window.location.origin + '/javascripts/TINYMCE/themes/modern/theme.js').replace("\/\/", "\/"),
  skin_url:  (window.location.origin + '/javascripts/TINYMCE/skins/lightgray/').replace("\/\/", "\/"),
  script_url: 'http://cloud.tinymce.com/4/tinymce.min.js'
});
