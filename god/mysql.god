God.watch do |w|
  w.name = 'mysql'
  w.start = '/usr/bin/mysqld_safe'
  w.keepalive
end
