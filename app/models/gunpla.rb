class Gunpla < ActiveRecord::Base
  has_many :gunpla_categories
  has_many :gunpla_series
  has_many :categories :through => :gunpla_categories
  has_many :series :through => :gunpla_series
end
