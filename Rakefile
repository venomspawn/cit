# frozen_string_literal: true

namespace :cit do
  desc 'Launches database migration'
  task :migrate, [:to, :from] do |_task, args|
    require_relative 'config/app_init'

    CIT::Init.run!('class_ext', 'logger', 'sequel')
    CIT.need 'tasks/migration'

    to = args[:to]
    from = args[:from]
    dir = "#{CIT.root}/db/migrations"
    CIT::Tasks::Migration.new(to, from, dir).launch!
  end
end
