Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :categories, only: %i[index create update]
      resources :dishes, except: %i[new edit] do
        get 'dish_list', to: 'dishes#dish_list_for_selector', on: :collection
      end
      resources :schedules, except: %i[new edit]
      resources :stuffs, only: %i[create update destroy]
      resources :sub_categories, only: %i[create update]
    end
  end
end
