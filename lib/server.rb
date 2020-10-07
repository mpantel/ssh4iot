require 'sinatra'

get '/:identifier' do
  "Get #{params[:identifier]}"
end

post '/:identifier/:public_key' do
  "Post id: #{params[:identifier]} key: #{params[:public_key]}"
end


delete '/:identifier' do
  "Delete #{params[:identifier]}"
end
