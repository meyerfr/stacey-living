class WelcomeCallJob < ApplicationJob
  queue_as :default

  def perform
    todays_date = Date.today
    WelcomeCall.where("start_time < ? AND available = ?", todays_date, true).destroy_all
    if todays_date.wday < 6 && todays_date.wday > 0
      WelcomeCall.create(start_time: Time.parse("#{todays_date + 14} 10:00"), end_time: Time.parse("#{todays_date + 14} 10:15"))
      while WelcomeCall.last.start_time < Time.parse("#{todays_date + 14} 17:30")
        WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
      end
    end
  end

  # def reschedule_job
  #   self.class.set(wait: 24.hours).perform_later
  # end
end
