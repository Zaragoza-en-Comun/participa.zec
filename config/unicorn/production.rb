directory = "/srv/rails/participa.zaragozaencomun.com"

working_directory "#{directory}/current"
pid "#{directory}/current/tmp/pids/unicorn.pid"
stderr_path "#{directory}/shared/log/unicorn.log"
stdout_path "#{directory}/shared/log/unicorn.log"
listen "/tmp/unicorn.participa.zaragozaencomun.com.sock"
worker_processes 4
timeout 120
