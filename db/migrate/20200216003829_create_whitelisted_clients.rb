class CreateWhitelistedClients < ActiveRecord::Migration[6.0]
  def change
    create_table :whitelisted_clients do |t|
      t.string :name
      t.string :domain
      t.string :token
      t.datetime :granted_on
      t.string :granted_by
      t.datetime :last_accessed_on
      t.string :last_accessed_by
      t.string :notes

      t.timestamps
    end
  end
end
