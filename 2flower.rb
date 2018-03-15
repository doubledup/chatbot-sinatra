require 'sinatra'
require 'json'
require 'pp'

response = 'Hello world from Sinatra'

post '/' do
  log_value('params', params)

  request.body.rewind
  body = JSON.parse(request.body.read)
  log_value('request body', body)
  df_params = body['result']['contexts'].map {|context| context['parameters']}
  log_value('parameters from dialogflow', df_params)

  location = df_params[0]['geo-city']
  date = df_params[0]['date']

  if (location == 'Singapore')
    make_response(%Q(That city-state's kinda warm, and it'll still be that way on #{date}))
  else
    make_response(%Q(Sinatra ain't sure about the weather at #{location} on #{date}))
  end
end

post '/:val' do
  log_value('params', params)
  log_value('val', params[:val])
  make_response(response)
end

get '/' do
  "Hello World"
end

get '/frank-says' do
  'Put this in your pipe & smoke it!'
end

private

def make_response(resp)
  JSON.dump({
    speech: resp,
    displayText: %q(Dave thinks display text doesn\'t matter. If you see this, go tell him he's wrong),
  })
end

def log_value(tag, val)
  pp "received #{tag}"
  pp val
end
