@users_index = (params) ->
  $('[data-toggle="tooltip"]').tooltip()

@users_merge = (params) ->
  $('.search').click (event) ->
    search_by_username(params)
    return

  $('.merge').click (event) ->
    merge(params)
    return

search_by_username = (params) ->
  $.ajax
    url: Routes.search_users_path()
    data:
      query: $('#query').val()
      id: params.id
    success: (response) ->
      return
    error: (response) ->
      window.location.href = Routes.merge_user_path(params.id)
      return
  return

merge = (params) ->
  ids = []
  checkbox = $('.users-table').find('tbody').find('tr').find('input[type=checkbox]:checked')
  $.each checkbox, (index, value) ->
    ids.push $(value).val()
    return
  $.ajax
    type: 'POST'
    url: Routes.merge_execute_user_path(params.id)
    data:
      user_ids: ids
    success: (json) ->
      window.location.href = Routes.edit_user_path(params.id)
      return
    error: (json) ->
      window.location.href = Routes.merge_user_path(params.id)
      return
  return