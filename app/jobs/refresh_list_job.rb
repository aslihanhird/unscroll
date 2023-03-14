class RefreshListJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 3

  def perform(list_id)
    list = List.find(list_id)
    list.refresh
  end
end
