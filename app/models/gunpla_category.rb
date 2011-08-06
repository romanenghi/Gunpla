class GunplaCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :gunpla
end
