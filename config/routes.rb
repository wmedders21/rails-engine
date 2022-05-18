Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        # scope :merchants do
          resources :items, only: [:index], controller: :merchant_items
        # end
      end
    end
  end
end









  #     resources :merchants, only: [:index, :show]
  #       resources merchant: :items, only: [:index]
  #     end
  #   end
  # end
