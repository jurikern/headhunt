Headhunt::Application.routes.draw do
  root to: 'main#index'

  devise_for :users, :path => '',
             :path_names  => {
                 :sign_in      => 'signin',
                 :sign_out     => 'signout',
                 :sign_up      => '',
                 :registration => 'signup'
             },
             :controllers => {
                 :registrations      => 'users/registrations',
                 :confirmations      => 'users/confirmations',
                 :passwords          => 'users/passwords',
                 :sessions           => 'users/sessions',
                 :omniauth_callbacks => 'users/omniauth_callbacks'
             }

  devise_scope :user do
    scope 'auth' do
      match ':name/destroy' => 'users/omniauth_callbacks#destroy', via: :delete, as: :omniauth_callback
    end
  end

  get '/profiles/subregion_options' => 'users/profiles#subregion_options'
  scope module: :users do
    resources :profiles
  end
end
