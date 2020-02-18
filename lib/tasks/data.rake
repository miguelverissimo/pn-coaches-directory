namespace :data do
  desc "Create sample data on the database"
  task hydrate: :environment do
    number = ENV.fetch('number', 8000).to_i
    puts "Creating #{number} coaches."
    puts "This may take a while..." if number > 1000

    FactoryBot.create_list(:coach, number)
  end

  desc "Create whitelisted client"
  task create_whitelisted_client: :environment do
    name = ENV.fetch('name', 'Unspecified Client')

    client = FactoryBot.create(:whitelisted_client, name: name)

    puts "Created whitelisted client '#{name}' with token '#{client.token}'"
    puts "Add 'Authorization: Token #{client.token}' to your requests"
  end
end
