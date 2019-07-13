class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :asc) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  
  validates_presence_of :title

  scope :exclude_classroom, -> { where(classroom: false) }

  def classroom?
    classroom
  end
end
