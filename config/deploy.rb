lock '3.8.1'

set :application, 'participa.zaragozaencomun.com'
set :repo_url, 'https://github.com/Zaragoza-en-comun/participa.zec'
set :linked_files, %w{config/database.yml config/secrets.yml config/mailserver.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system db/podemos}

set :user, 'participa'
set :ssh_options, forward_agent: true
