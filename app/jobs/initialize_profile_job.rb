class InitializeProfileJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(profile_id)
    profile = Profile.find(profile_id)
    profile.refresh
  end
end
