class WelcomeCallJob < ApplicationJob
  queue_as :default

  def perform
    if Date.today.wday > 0 && Date.today.wday < 6
      WelcomeCall.create(start_time: Time.parse("#{Date.today + 14} 11:00"), end_time: Time.parse("#{Date.today + 7} 11:15"))
      while WelcomeCall.last.start_time < Time.parse("#{Date.today + 14} 18:30")
        WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
      end
    end
    reschedule_job
  end

  def reschedule_job
    self.class.set(wait: 24.hours).perform_later
  end
end