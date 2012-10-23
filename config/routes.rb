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
                 :registrations => 'users/registrations',
                 :confirmations => 'users/confirmations',
                 :passwords     => 'users/passwords',
                 :sessions      => 'users/sessions'
             }
end
