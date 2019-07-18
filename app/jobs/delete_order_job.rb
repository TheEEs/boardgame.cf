class DeleteOrderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    id = args.first
    Order.destroy(id)
  rescue
    true
  end
end
