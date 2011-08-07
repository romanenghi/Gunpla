class Category < ActiveRecord::Base
  has_many :gunpla, :through => :gunpla_series
  has_many :gunpla_series
end
