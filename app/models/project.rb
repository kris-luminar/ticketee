class Project < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :tickets

  validates :name, :presence => true
end
