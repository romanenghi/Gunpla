class Gunpla < ActiveRecord::Base
  has_many :gunpla_categories
  has_many :gunpla_series
  has_many :categories, :through => :gunpla_categories
  has_many :series, :through => :gunpla_series
  has_many :images
  has_one :data1999
  has_one :datahlj
  has_one :datacosmic
end
