$ ->
  if $('#services').length > 0
    player_id = $('#services').data 'player-id'
    setInterval ->
      $.ajax
        url: "/services/#{player_id}"
        success: (data) ->
          times = data.times
          prices = data.prices
          console.log times
          console.log prices
      , 3000

