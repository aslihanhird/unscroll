class NewProfileJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(source, username, list)
    list.new_profile(source, username)
  end
end
