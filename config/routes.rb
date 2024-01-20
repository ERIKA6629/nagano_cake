Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope module: :public do
    get '/' => 'homes#top', as: 'public_top'
    get 'about' => 'homes#about', as: 'public_about'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'information_edit'
    patch 'customers/information' => 'customers#update'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'custoners#withdraw'
    
    resources :orders, only: [:new, :index, :show, :create]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
  end
  
  namespace :admin do
    get '/' => 'homes#top'
    resources :items
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  
  
end
