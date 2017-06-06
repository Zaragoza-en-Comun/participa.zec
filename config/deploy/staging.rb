server 'participa.zaragozaencomun.com', user: 'participa', port: 22, roles: %w(db web app)

set :branch, ENV['BRANCH'] || :master
set :deploy_to, '/home/participa/betaparticipa.zaragozaencomun.com'

after 'deploy:publishing', 'passenger:restart'
