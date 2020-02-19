class MissingWelcomeCallsJob < ApplicationJob
  queue_as :default

  def perform
    WelcomeCall.create(start_time: Time.parse("27.02.2020 10:00"), end_time: Time.parse("27.02.2020 10:15"))
    while WelcomeCall.last.start_time < Time.parse("27.02.2020 17:30")
      WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
    end
    WelcomeCall.create(start_time: Time.parse("28.02.2020 10:00"), end_time: Time.parse("28.02.2020 10:15"))
    while WelcomeCall.last.start_time < Time.parse("28.02.2020 17:30")
      WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
    end
    WelcomeCall.create(start_time: Time.parse("02.03.2020 10:00"), end_time: Time.parse("02.03.2020 10:15"))
    while WelcomeCall.last.start_time < Time.parse("02.03.2020 17:30")
      WelcomeCall.create(start_time: WelcomeCall.last.start_time + 30.minutes, end_time: WelcomeCall.last.end_time + 30.minutes)
    end
  end
end
