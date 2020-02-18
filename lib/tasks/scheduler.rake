desc "This task is called by the Heroku scheduler add-on every day"
task :update_welcome_call => :environment do
  puts "Deleting old not scheduled welcome_calls"
  WelcomeCall.select{|c| c.start_time.to_date < Date.today && c.available == true }.delete_all
  if Date.today.wday > 0 && Date.today.wday < 6
    puts "Creating new welcome_calls in 14 days."
    WelcomeCall.create(start_time: Time.parse("#{Date.today + 14} 10:00"), end_time: Time.parse("#{Date.today + 7} 11:15"))
    while WelcomeCall.last.start_time < Time.parse("#{Date.today + 14} 17:30")
      WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
    end
  else
    puts "No welcome_call created, because it´s weekend."
  end
  puts "Done"
end
