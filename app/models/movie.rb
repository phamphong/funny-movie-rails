class Movie < ApplicationRecord
  belongs_to :user

  #Validations
  validates_presence_of :title, :code, :url, :description
  validates :code, uniqueness: true

end
