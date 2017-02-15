God.watch do |w|
  w.name = 'apache'
  w.start = '/usr/sbin/apache2ctl -D FOREGROUND'
  w.stop = '/usr/sbin/apache2ctl stop'
  w.keepalive
end
