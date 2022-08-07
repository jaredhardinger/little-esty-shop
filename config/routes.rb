Rails.application.routes.draw do
  resources :merchants, only: [:index, :create] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
  end

  get '/', to: "welcome#index"

  get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
  post '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#update'
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  get '/admin', to: 'admin#dashboard'

  get '/admin/invoices', to: 'admin#index'
  get '/admin/invoices/:id', to: 'admin#show'
  patch '/admin/invoices/:id/update', to: 'admin#update'

  get '/admin/merchants/new', to: 'admin#new'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:merchant_id', to: 'admin_merchants#show'
  get '/admin/merchants/:merchant_id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:merchant_id/update', to: 'admin_merchants#update'
  patch '/admin/merchants/:merchant_id/update-status', to: 'admin_merchants#update'
  post '/admin/merchants', to: 'admin_merchants#create'

  get '/merchants/:merchant_id/bulk_discounts', to: "bulk_discounts#index"
  get "/merchants/:merchant_id/bulk_discounts/new", to: "bulk_discounts#new"
  get '/merchants/:merchant_id/bulk_discounts/:discount_id', to: "bulk_discounts#show"
  post '/merchants/:merchant_id/bulk_discounts/new', to: 'bulk_discounts#create'
end
