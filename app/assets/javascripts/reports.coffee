@reports_master = (params) ->
  $('[data-toggle="tooltip"]').tooltip()

  $('#multiple-mettings').multiselect
    nonSelectedText: 'Mettings'
    includeSelectAllOption: true
    selectAllText: 'Select all'
    selectAllValue: 0
    maxHeight: 300
    buttonClass: 'btn btn-secondary'
    templates:
      li: "<li><a tabindex='0' class='dropdown-item'><label></label></a></li>"

  $('#single-filter').multiselect
    maxHeight: 300
    buttonClass: 'btn btn-secondary'
    templates:
      li: "<li><a tabindex='0' class='dropdown-item'><label></label></a></li>"

  $('#master-search').click ->
    master_search()
    return false

  $('#master-export').click ->
    export_master_search()
    return false

master_search = ->
  $.ajax
    url: Routes.master_reports_path(format: 'js')
    data:
      filter: $('#multiple-mettings').val()
      order: $('#single-filter').val()
    success: (response) ->
      return
    error: (response) ->
      Routes.master_reports_path()
      return
  return

export_master_search = ->
  url = Routes.master_reports_path(format: 'csv', filter: $('#multiple-mettings').val(), order: $('#single-filter').val())
  $('<a>').attr('href', url).attr('target', '_blank')[0].click()