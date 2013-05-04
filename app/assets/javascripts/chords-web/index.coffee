$ ->
  $('#fetch-index').click fetchIndex
  $('#index-file-name').val index_path if index_path = location.hash[1..] or localStorage?.getItem 'index_path'
  fetchIndex()

fetchIndex = ->
  return unless index_path = $('#index-file-name').val()
  localStorage?.setItem 'index_path', index_path
  location.hash = index_path
  $.post 'fetch', {index_path} , (index)->
    container = $('#index').empty()
    for f in index
      $('<a/>').text("#{f.title} [#{f.author}]")
        .attr(target: '_blank', href: "show?#{$.param song_path: f.path}")
        .appendTo(container).wrap('<div/>')
