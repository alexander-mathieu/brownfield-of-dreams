class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :asc) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates_format_of :thumbnail, with: %r(\Ahttps:\/\/i\.ytimg\.com\/vi\/([a-zA-Z0-9_-]*)\/hqdefault\.jpg\Z), on: :create

  scope :exclude_classroom, -> { where(classroom: false) }

  def classroom?
    classroom
  end
end
