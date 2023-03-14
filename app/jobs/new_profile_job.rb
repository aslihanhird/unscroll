class NewProfileJob < ApplicationJob
  queue_as :default

  def perform(source, username, list)
    list.new_profile(source, username)
  end
end
