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
    user_request = user_info(twitch_token)

    json_user = JSON.parse(user_request.body)['data'][0]

    go_to_config(json_user)
  end

  private

  def go_to_config(json_user)
    if User.find_by(id: json_user['id'])
      log_in(User.find(json_user['id']))
    else
      new_user = User.new(username: json_user['login'], email: json_user['email'], id: json_user['id'])
      new_user.avatar.attach(io: URI(json_user['profile_image_url']).open, filename: "#{json_user['login']}.jpg")
      new_user.save
      log_in(new_user)
    end

    redirect_to config_path
  end

  def twitch_token
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
    puts 'data', JSON.parse(x.body)

    JSON.parse(x.body)['access_token']
  end

  def user_info(access_token)
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
