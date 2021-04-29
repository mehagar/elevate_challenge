Rails.application.routes.draw do
  get 'games/index'
  scope '/api' do
    post 'user', to: 'users#sign_up'
    post 'sessions', to: 'sessions#sign_in'
    get 'games', to: 'games#index'
  end
end
