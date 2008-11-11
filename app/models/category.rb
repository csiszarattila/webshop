class Category < ActiveRecord::Base
	has_many :products
	has_many :attrs, :class_name => "CategoryAttribute"
	acts_as_tree :order => "name"

	validates_presence_of :name
	validates_uniqueness_of :name, :scope => [:parent_id], :message => "a kategórián belül egyedinek kell lennie"
	
	named_scope :roots, :conditions => {:parent_id => nil}
end
