#!/usr/bin/env ruby

require 'fileutils'

def install(pkgs)
  system('apt', 'install', '--assume-yes', *pkgs) || raise
end

install(%w(apache2 libapache2-mod-php php-mysql mysql-server php-gd php-xml))
install(%w(git subversion wget))
install(%w(openssh-server))

Dir.chdir('/var/www/') do
  system('wget https://ftp.drupal.org/files/projects/drupal-8.2.6.tar.gz') || raise
  Dir.mkdir('drupal')
  system('tar -xf drupal-*.tar.gz -C drupal --strip-components=1') || raise
  FileUtils.rm(Dir.glob('drupal-*.tar.gz'))
end

# So install can work.
FileUtils.chown_R('www-data', 'www-data', '/var/www/drupal')

FileUtils.cp('/tmp/assets/vhost.conf',
             '/etc/apache2/sites-enabled/000-default.conf')

system('a2enmod rewrite') # drupal clean urls
system('a2enmod proxy')
system('a2enmod proxy_http')
system('a2enmod proxy_connect') # for ssl
system('a2enmod ssl') # for to kde.org
# FIXME: it may be wise to use something other than cgi here as cgi is slow AF
# mod_lua might do the job equally well.
system('a2enmod cgi') # for error handling

# workaround shit packaging
FileUtils.mkdir('/var/run/mysqld')
FileUtils.chown('mysql', 'mysql', '/var/run/mysqld')

FileUtils.mkdir('/var/www/handlers')
FileUtils.cp('/tmp/assets/404.rb', '/var/www/handlers/')
FileUtils.chmod(0o755, '/var/www/handlers/404.rb')

FileUtils.chown_R('www-data', 'www-data', '/var/www')
