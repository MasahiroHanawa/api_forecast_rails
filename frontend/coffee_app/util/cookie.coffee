
cookie = ->
  cookies = document.cookie.split("; ")
  cookieList = []
  cookies.map((cookie) ->
    (
      cookies = cookie.split("=")
      cookieList[cookies[0]] = cookies[1]
    )
  )
  return cookieList


module.exports = cookie