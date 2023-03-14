class InitializeProfileJob < ApplicationJob
  queue_as :default

  def perform(profile_id)
    profile = Profile.find(profile_id)
    profile.refresh
  end
end
