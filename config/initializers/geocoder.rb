# Configure Geocoder.  Notes to think about:
# * Geokit sucks, Geocoder is much better :)
# * Google Rate Limits by IP Address.  My IP Address had been maxed
#   out, when tethering on my phone, even though I didn't use any
#   requests, and there was no way to say "This is me"
# * I choose bing, basic is free, seems to be good enough.

Geocoder.configure({
  :lookup  => :bing,
  :api_key => ENV['BING_GEOCODER_API_KEY'],
  :timeout => 5,
  :units => :miles,

  # caching (see below for details):
  #:cache => Redis.new,
  #:cache_prefix => "..."
})

