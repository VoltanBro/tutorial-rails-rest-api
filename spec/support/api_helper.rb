# spec/support/api_helper.rb
module ApiHelper
  def authenticated_header(options)
    user = options[:user]
    token = JsonWebToken.encode(user_id: user.id)
    if options[:user] and options[:request]
      request = options[:request]
      request.headers.merge!('Authorization': "Bearer #{token}")
    else
      "Bearer #{token}"
    end
  end


  def authenticated_header2(user)
    token = JsonWebToken.encode(user_id: user.id)
    "Bearer #{token}"
  end
end