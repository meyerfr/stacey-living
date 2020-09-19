desc "This task is called by the Heroku scheduler add-on every day"
task :update_welcome_call => :environment do
  todays_date = Date.today
  puts "Deleting old not scheduled welcome_calls"
  WelcomeCall.where("start_time < ? AND available = ?", todays_date, true).destroy_all
  if todays_date.wday > 0 && todays_date.wday < 6
    puts "Creating new welcome_calls in 15 days."
    WelcomeCall.create(start_time: Time.parse("#{todays_date + 15} 10:30"), end_time: Time.parse("#{todays_date + 15} 10:45"))
    while WelcomeCall.last.start_time < Time.parse("#{todays_date + 15} 17:30")
      WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
    end
  else
    puts "No welcome_call created, because it´s a weekend day."
  end
  puts "update_welcome_call job done"
end
