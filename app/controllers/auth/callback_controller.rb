class Auth::CallbackController < ApplicationController
  def twitter
    twitter_uid = request.env['omniauth.auth']['uid']

    twitter_auth = TwitterAuth.find_by_uid(twitter_uid)

    if twitter_auth.present?
      twitter_auth.update_attribute(:nickname, request.env['omniauth.auth']['info']['nickname'])

      session[:user_id] = twitter_auth.user_id
    else
      User.transaction do 
        new_user = User.create!
        new_user.create_twitter_auth!(
          uid: twitter_uid,
          nickname: request.env['omniauth.auth']['info']['nickname']
        )

        session[:user_id] = new_user.id
      end
    end
  end
end
