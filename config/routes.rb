Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :dishes do
        get 'dish_list', to: 'dishes#dish_list_for_selector', on: :collection
      end
      resources :schedules
    end
  end
end
