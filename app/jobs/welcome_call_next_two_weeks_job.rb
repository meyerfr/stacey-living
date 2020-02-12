class WelcomeCallNextTwoWeeksJob < ApplicationJob
  queue_as :default

  def perform()
    duration = Date.tomorrow..(Date.today + 13)
    dates = duration.select{ |day| day.wday > 0 && day.wday < 6 }
    dates.each do |day|
      WelcomeCall.create(start_time: Time.parse("#{day} 11:00"), end_time: Time.parse("#{day} 11:15"))
      while WelcomeCall.last.start_time < Time.parse("#{day} 18:30")
        WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
      end
    end
  end
end
