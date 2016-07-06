class AplicationMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    AplicationMailer.sample_email(User.first)
  end
end
