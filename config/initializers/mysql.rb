unless VCards.production?
  unless File.exist?('/tmp/mysql.sock')
    if File.exist?('/var/run/mysqld/mysqld.sock')
      system('ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock')
    end
  end
end
