# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'itembox'
set :repo_url, 'git@github.com:a3vorobyov/itembox.git'
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system',
  'uploads'
)
set :keep_releases, 5
set :rails_env, 'production'
set :rvm_type, :user
set :rvm_ruby_version, '2.3.0'
set :puma_init_active_record, true
set :puma_preload_app, true

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :finishing,    :compile_assets
  after :finishing,    :cleanup
  after :finishing,    :restart
end
