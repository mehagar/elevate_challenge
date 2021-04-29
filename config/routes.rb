Rails.application.routes.draw do
  get 'games/index'
  scope '/api' do
    scope '/user' do
      post '/', to: 'users#sign_up'
      post 'game_events', to: 'users#create_game_event'
    end

    post 'sessions', to: 'sessions#sign_in'
    get 'games', to: 'games#index'
  end
end
