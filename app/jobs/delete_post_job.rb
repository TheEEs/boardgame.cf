class DeletePostJob < ApplicationJob
  queue_as :default

  def perform(*args)
    id = args.first
    Post.destroy(id)
  rescue
    true
  end
end
