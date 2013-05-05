$ ->
  $('#song-content').on('change keyup mouseup input', onContentChange).change()
  $('#inplace-edit').on('change', -> $('#song-content').toggle(this.checked))
  setupTransposition()
  setupChordsVisibility()

onContentChange = ->
  $('#song').html(processSong($(this).val()))
  $('#song tr.chords').toggle($('#show-real-chords')[0].checked)
  $('#song tr.normalized-chords').toggle($('#show-normalized-chords')[0].checked)
  $('#song tr.lyrics').toggle($('#show-lyrics')[0].checked)

processSong = (input) ->
  parser = new Parser(input)
  new HtmlFormatter(parser.parse()).format()

setupTransposition = ->
  $(document).on 'click', '#song .tone', -> $('#transposition').dialog()
  $('#transposition select').on 'change', ->
    return unless tone = $('#transposition select').val()
    transposed = new SourceTransposer($('#song-content').text(), tone).transposedSource()
    $('#song-content').text(transposed).change()

setupChordsVisibility = ->
  $('#show-real-chords').change -> $('#song tr.chords').toggle()
  $('#show-normalized-chords').change -> $('#song tr.normalized-chords').toggle()
  $('#show-lyrics').change -> $('#song tr.lyrics').toggle()
