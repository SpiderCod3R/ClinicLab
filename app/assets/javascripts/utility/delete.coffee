$.rails.allowAction = (element) ->
  message = element.data('confirm')
  return true unless message
  $link = element.clone()
    .removeAttr('class')
    .removeAttr('data-confirm')
    .addClass('btn').addClass('btn-primary')
    .html("Sim")
  modal_html = """
               <div class="modal fade" id="delete_dialog">
                 <div class="modal-dialog">
                   <div class="modal-content">
                     <div class="modal-header">
                       <a class="close" data-dismiss="modal">×</a>
                       <p>#{message}</p>
                     </div>
                     <div class="modal-body">
                       <p>Quer mesmo excluir?</p>
                     </div>
                     <div class="modal-footer">
                       <a data-dismiss="modal" class="btn btn-default">Calcelar</a>
                     </div>
                   </div>
                 </div>
               </div>
               """
  $modal_html = $(modal_html)
  $modal_html.find('.modal-footer').append($link)
  $modal_html.modal()
  return false
