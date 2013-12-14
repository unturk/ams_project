class Aidat < ActiveRecord::Base
  validates_uniqueness_of :daire, scope: [:year, :month]
end
