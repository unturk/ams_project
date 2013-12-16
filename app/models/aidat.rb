#Database model for subscription
class Aidat < ActiveRecord::Base
  validates_uniqueness_of :daire, scope: [:year, :month]
  #default_scope order("#{self.table_name}.year ASC")
end
