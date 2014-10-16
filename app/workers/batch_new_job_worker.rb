class BatchNewJobWorker
  include Sidekiq::Worker

  def perform(job_id)
    job = Job.find(job_id)
    users_to_message = User.near(job.location, 5)

    users_to_message.each do |receiver|
      NewJobWorker.perform_async(receiver.id, job.id)
    end
  end
end
