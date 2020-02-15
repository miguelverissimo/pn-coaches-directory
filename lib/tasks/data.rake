namespace :data do
  desc "Create sample data on the database"
  task hydrate: :environment do
    number = ENV.fetch('number', 8000).to_i
    puts "Creating #{number} coaches."
    puts "This may take a while..." if number > 1000

    FactoryBot.create_list(:coach, number)
  end
end
