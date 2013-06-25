require 'sinatra'
require 'json'
require_relative 'lib/converter'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
end

post "/converter" do
  doc = params['file'][:tempfile].read

  content_type :json
  Converter::to_json( doc ).to_json.to_json
end

get '/converter' do
  erb :upload_form
end