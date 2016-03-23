class SessionsController < ApplicationController
  def create
    if auth_hash
      authentication = Authentication.where(provider: auth_hash.provider, uid: auth_hash.uid).first
      if authentication
        binding.pry
        user = User.find_by(id: authentication.user_id)
        authentication.update_attributes!(
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret
        )
      else

        user = user_signed_in? ? current_user : User.new(name: auth_hash.info.name, email: get_email)
        binding.pry
        user.save(validate: false)
        Authentication.create(
          provider: auth_hash.provider,
          uid: auth_hash.uid,
          token: auth_hash.credentials.token,
          secret: auth_hash.credentials.secret,
          user_id: user.id
        )
      end
      sign_in(user, bypass: true)
      session[:user_id] = user.id unless user_signed_in?
    end
    redirect_to root_path
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end

  def expires_at
    if auth_hash.credentials.expires_at.present?
      Time.at(auth_hash.credentials.expires_at).to_datetime
    elsif auth_hash.credentials.expires_in.present?
      DateTime.now + auth_hash.credentials.expires_in.to_i.seconds
    end
  end

  def get_email
    return auth_hash.info.email if auth_hash.info.email.present?
    if auth_hash.info.email.blank?
      email = auth_hash.info.nickname || auth_hash.info.user_name || auth_hash.info.username
    end
    "#{email}@example.com"
  end
end
