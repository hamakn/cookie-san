require "sinatra/base"
require "sinatra/cookies"
require "json"

class App < Sinatra::Base
  helpers Sinatra::Cookies

  get "/" do
    @jj_cookie_json = JSON.pretty_generate(cookies.to_h)
    haml :index
  end

  get "/new" do
    @cookie_str = "{\"hoge\":1}"
    haml :edit
  end

  post "/create" do
    cookies.clear
    begin
      JSON.parse(params["cookie_json"]).each do |k, v|
        cookies[k] = v
      end
      redirect to("/")
    rescue
      redirect to("/new")
    end
  end

  get "/destroy" do
    cookies.clear
    redirect to("/")
  end
end
