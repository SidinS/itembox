server '52.34.212.15', user: 'ubuntu', roles: %w(app db web)

set :deploy_to, "/var/www/sites/#{fetch :application}"
set :backup_to, "/var/www/backups/#{fetch(:application)}"

set :branch, ENV['BRANCH'].to_s.empty? ? 'production' : ENV['BRANCH'].to_s

set :whenever_environment, 'production'
