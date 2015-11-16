$ ->
  $('.timestring').each ->
    form_time = moment(this.textContent)
    seven_days_ago = moment().subtract('days', 7)
    if form_time.isBefore(seven_days_ago)
      this.textContent = moment(this.textContent).format('LL')
    else
      this.textContent = moment(this.textContent).fromNow()

  clip = new ZeroClipboard($('#d_clip_button'))
  $('#d_clip_button').click ->
    $(this).text('已复制成功').addClass 'disabled'
    setTimeout (->
      $('#d_clip_button').text('复制链接').removeClass 'disabled'
      return
    ), 3000
    return
