Rails.application.routes.draw do
  root 'static#index'
  get '/pugbomb',   to: 'static#pugbomb'
  get '/celebrate', to: 'static#celebrate'
end
