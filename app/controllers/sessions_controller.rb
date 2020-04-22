require 'uri'
require 'net/http'
require 'open-uri'

class SessionsController < ApplicationController
  def login
    redirect_to "https://id.twitch.tv/oauth2/authorize?client_id=#{ENV['CLIENT_ID']}&redirect_uri=#{ENV['URL_BACK']}&response_type=code&scope=user:edit+user:read:email"
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def auth
    twitch = twitch_tokens
    p 'twitch', twitch, twitch[:access_token]
    user_request = user_info(twitch[:access_token])

    json_user = JSON.parse(user_request.body)['data'][0]

    go_to_config(json_user, twitch)
  end

  private

  def go_to_config(json_user, twitch)
    p json_user
    if User.find_by(id: json_user['id'])
      log_in(User.find(json_user['id']))
      current_user.update_attribute(:twitch_token,twitch[:access_token])
      current_user.update_attribute(:twitch_refresh,twitch[:refresh_token])
    else
      new_user = User.new(username: json_user['login'],
                          email: json_user['email'],
                          id: json_user['id'],
                          main_string: SecureRandom.base64(10),
                          twitch_token: twitch[:access_token],
                          twitch_refresh: twitch[:refresh_token])

      new_user.avatar.attach(io: URI(json_user['profile_image_url']).open, filename: "#{json_user['login']}.jpg")
      new_user.save
      Config.create(direction: true, show: false, black_list: '', bubble: '', user_id: new_user.id)
      log_in(new_user)
    end

    redirect_to edit_config_path
  end

  def twitch_tokens
    p 'cid: ', ENV['CLIENT_ID']
    client_id = ENV['CLIENT_ID']
    uri = ENV['URL_BACK']
    client_secret = ENV['CLIENT_SECRET']
    grant_type = 'authorization_code'

    url = 'https://id.twitch.tv/oauth2/token?'\
    "client_id=#{client_id}" \
    "&client_secret=#{client_secret}"\
    "&code=#{params[:code]}"\
    "&grant_type=#{grant_type}"\
    "&redirect_uri=#{uri}"

    params = {}
    x = Net::HTTP.post_form(URI.parse(url), params)

    { access_token: JSON.parse(x.body)['access_token'], refresh_token: JSON.parse(x.body)['refresh_token'] }
  end

  def user_info(access_token)
    p 'access', access_token
    uri = URI.parse('https://api.twitch.tv/helix/users')
    request = Net::HTTP::Get.new(uri)
    request['Authorization'] = "Bearer #{access_token}"

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end
end
