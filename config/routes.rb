Rails.application.routes.draw do
  scope '/api' do
    post 'user', to: 'users#sign_up'
    post 'sessions', to: 'sessions#sign_in'
  end
end
