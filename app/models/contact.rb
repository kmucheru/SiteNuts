class Contact < MailForm::Base
  append :remote_ip, :user_agent, :session
  attr_accessor :country
  attribute :name,      :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message
  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "Sitenuts",
      :to => "kevinmucheruk@gmail.com",
      :from => %("#{name}" <#{email}>)
    }
  end
end
