class DeleteActivityJob < ApplicationJob
  queue_as :default

  def perform(*args)
    id = args.first
    Activity.destroy(id)
  rescue
    true
  end
end
