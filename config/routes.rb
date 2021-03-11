Rails.application.routes.draw do
  resources :likes, only: %i[popular fan week]  do
    get :popular, on: :collection
    get :fan, on: :collection
    get :week, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
