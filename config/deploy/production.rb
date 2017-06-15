server '13.58.174.115', user: 'ec2-user', roles: %w(app db web)

set :deploy_to,  "/var/www/sites/#{fetch :application}"
set :backup_to, "/var/www/backups/#{fetch(:application)}"

set :branch, 'production'

set :whenever_environment, 'production'
