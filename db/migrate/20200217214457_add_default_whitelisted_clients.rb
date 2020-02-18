require 'active_record/fixtures'

class AddDefaultWhitelistedClients < ActiveRecord::Migration[6.0]
  def up
    down

    ActiveRecord::FixtureSet.create_fixtures(Rails.root.join('db/hydration_fixtures'), 'whitelisted_clients')
  end

  def down
    WhitelistedClient.delete_all
  end
end
