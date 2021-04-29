Rails.application.routes.draw do
  get 'test2/test'
  scope '/api' do
    post 'users/sign_up'
  end
end
