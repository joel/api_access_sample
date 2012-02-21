Apiaccess::Application.routes.draw do

  devise_for :users

  root :to => "contacts#providers"

  get 'contacts/providers' => "contacts#providers"
  match '/contacts/:provider/provider' => 'contacts#provider', :via => :get
  match '/contacts/:provider/authorize' => 'contacts#authorize' #, :via => :post
  match '/contacts/:provider/contacts' => 'contacts#contacts', :as => :contacts, :via => :get

end
