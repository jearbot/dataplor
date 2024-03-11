Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :ancestors do
    get '/common_ancestors', to: 'ancestors#show'
  end

  resource :birds do
    get '/birds', to: 'birds#show'
  end
end
