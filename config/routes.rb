Rails.application.routes.draw do
  resources :likes, only: %i[popular_posts biggest_fans popular_days]  do
    get :popular_posts, on: :collection
    get :biggest_fans, on: :collection
    get :popular_days, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
