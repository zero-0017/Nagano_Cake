Rails.application.routes.draw do

  namespace :admin do
    get 'genres/index'
    get 'genres/show'
  end
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    resources :items, only: [:show, :index, :new, :edit, :create, :update]
    resources :orders, only: [:show, :update] do
    resources :order_item,only: [:update]
    end
    resources :genres, only: [:index, :create, :edit, :update]
  end

  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#top'
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
      post '/confirm' => 'orders#confirm'
      get '/thanks' => 'orders#thanks'
      end
    end
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      delete 'cart_items/all_destroy' =>'cart_items#all_destroy'
    end

    resources :items, only: [:index, :show]
    get 'customers/infomation/edit' => 'customers#edit'
    patch 'customers/infomation' => 'customers#update'

    resources :customers,only:[:show] do
     collection do
        get 'unsubscribe'
        patch 'withdrawal'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
