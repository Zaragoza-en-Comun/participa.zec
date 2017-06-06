role :app, %w{participa@participa.zaragozaencomun.com}
role :web, %w{participa@participa.zaragozaencomun.com}
role :db,  %w{participa@participa.zaragozaencomun.com}

set :rvm_ruby_version, '2.3.3'
set :branch, ENV['BRANCH'] || :master
set :deploy_to, '/srv/rails/participa.zaragozaencomun.com'

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :start do
    on roles(:app) do
      execute "/etc/init.d/unicorn_production start"
    end
  end
  task :stop do
    on roles(:app) do
      execute "/etc/init.d/unicorn_production stop"
    end
  end
  task :restart do
    on roles(:app) do
      execute "/etc/init.d/unicorn_production restart"
    end
  end
end
