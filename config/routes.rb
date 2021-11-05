Rails.application.routes.draw do

  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  devise_for :admin, controllers: {
    sessions:      'admin/sessions'
    # passwords:     'admins/passwords',
    # registrations: 'admins/registrations'
  }

  namespace :admin do
    root 'homes#top'
    resources :genres,    only:[:index, :create, :edit, :update]
    resources :items,     only:[:index, :new, :create, :show, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :order,     only:[:show, :update]


  end
end
