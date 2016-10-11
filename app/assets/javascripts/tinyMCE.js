 tinyMCE.init({
    selector: 'textarea.editor',
    theme_url: (document.location.pathname + '/javascripts/TINYMCE/themes/modern/theme.js').replace("\/\/", "\/"),
    skin_url:  (document.location.pathname + '/javascripts/TINYMCE/skins/lightgray/').replace("\/\/", "\/")
  });
