require 'sinatra'
require 'json'
require_relative 'lib/converter'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  set :raise_errors, false
  set :show_exceptions, false
end

error do
  content_type :html

  @error = env['sinatra.error'].message

  halt erb :error
end

post "/qdm2json" do
  doc = params['file'][:tempfile].read
  version_param = params['version']

  version =
  if version_param.to_s.empty?
    HQMF::Parser::HQMF_VERSION_1
  else
    version_param
  end

  content_type :json
  Converter::to_json( doc, version ).to_json.to_json
end

get '/' do
  erb :home
end

get '/api' do
  erb :api
end