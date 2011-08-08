class Gunpla < ActiveRecord::Base
  has_many :gunpla_categories, :dependent => :destroy
  #has_many :gunpla_series, :dependent => :destroy
  has_many :categories, :through => :gunpla_categories
  has_many :series, :through => :gunpla_series
  has_many :images, :dependent => :destroy
  has_one :data1999, :dependent => :destroy
  has_one :datahlj, :dependent => :destroy
  has_one :datacosmic, :dependent => :destroy
  
  validates_presence_of :code
  validates_uniqueness_of :code
end
