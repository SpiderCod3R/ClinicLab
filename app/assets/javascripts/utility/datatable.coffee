# $(document).ready ->
#   table = $('#data-table').DataTable()
#   # tt = new ($.fn.dataTable.TableTools)(table)
#   #$(tt.fnContainer()).insertBefore 'div.dataTables_wrapper'
#   return

$('.datatable').DataTable({
  #ajax: ...,
  #autoWidth: false,
  #pagingType: 'full_numbers',
  #processing: true,
  #serverSide: true,

  #Optional, if you want full pagination controls.
  #Check dataTables documentation to learn more about available options.
  #http://datatables.net/reference/option/pagingType
})
