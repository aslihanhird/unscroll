class RefreshListJob < ApplicationJob
  queue_as :default

  def perform(list_id)
    list = List.find(list_id)
    list.refresh
  end
end
