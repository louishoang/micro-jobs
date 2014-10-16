class NewJobWorker
  include Sidekiq::Worker

  def perform(user_id, job_id)
    job = Job.find(job_id)
    user = User.find(user_id)
    employer = job.employer

    body = "There is a new job matching your skills\n\n"
    body = body + job.name + "posted by " + employer.first_name + employer.last_name

    TextMessage.new(user.phone_number, body).send
  end
end
