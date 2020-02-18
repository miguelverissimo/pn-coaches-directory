require 'active_record/fixtures'

class AddDefaultWhitelistedClients < ActiveRecord::Migration[6.0]
  def up
    down

    dir = Rails.root.join('db/hydration_fixtures')
    if dir.join('whitelisted_client.yml').exist?
      ActiveRecord::FixtureSet.create_fixtures(dir, 'whitelisted_client')
    end
  end

  def down
    WhitelistedClient.delete_all
  end
end
