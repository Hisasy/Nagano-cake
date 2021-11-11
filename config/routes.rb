Rails.application.routes.draw do

  root to: 'homes#top'
  get '/about' => 'homes#about'

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

  scope module: :public do
    get 'customers/quit'  => 'customers#quit', as: 'customers_quit'
    patch 'customers/out' => 'customers#out', as: 'customers_out'
    get 'orders/comfirm'  => 'orders#comfirm'
    get 'orders/thanks'   => 'orders#thanks'

    resources :customers,  only:[:show, :edit, :update]
    resources :addresses,  only:[:index, :edit, :create, :update, :destroy]
    resources :items,      only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create]
    resources :orders,     only:[:new, :create, :index, :show]
    delete 'cart_items/all_destroy' => 'cart_items#all_destroy'
  end

  namespace :admin do
    root 'homes#top'
    resources :genres,        only:[:index, :create, :edit, :update]
    resources :items,         only:[:index, :new, :create, :show, :edit, :update]
    resources :customers,     only:[:index, :show, :edit, :update]
    resources :order,         only:[:show, :update]
    resources :order_details, only:[:update]
  end
end
