class Project < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :tickets, :dependent => :delete_all

  validates :name, :presence => true
end
