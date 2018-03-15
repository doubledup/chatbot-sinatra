require 'sinatra'

post '/' do
  request.body.rewind
  body = JSON.parse(request.body.read)

  df_params = body['result']['parameters']
  colour = df_params['colour']
  number = df_params['number']

  make_response(%Q(Your silly name is #{colour}-#{number}. Congrats!))
end

private

def make_response(msg)
  JSON.dump({
    speech: msg,
    displayText: %q(Dave thinks display text doesn\'t matter. If you see this, go tell him he's wrong),
  })
end
