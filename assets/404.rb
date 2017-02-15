#!/usr/bin/env ruby

REQUEST_URI = ENV.fetch('REQUEST_URI')

if REQUEST_URI.start_with?('/legacy/')
  # The legacy proxy came back 404 meaning the page doesn't exist at all.
  exit 1
end

puts <<EOS
Content-type: text/html
Status: 301 Moved Permanently
Location: /legacy#{REQUEST_URI}

<html><body>
#{ARGV}
<br/><br/>
#{ENV.inspect.gsub('", "', "<br/>")}
</body></html>
EOS
