Rails.application.routes.draw do

  resources :items

  mount TranslatedModel::Engine => "/translated_model"
end
