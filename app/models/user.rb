class User < ApplicationRecord
  has_many :usertags
  has_many :tags, through: :usertags

  def tag_names
    tags.map(&:name).sort
  end

  def tag_with(*tags_or_tag_names)
    tags_or_tag_names.each do |tag_or_tag_name|
      case tag_or_tag_name
      when Tag
        the_tag = tag_or_tag_name
      when String, Symbol
        the_tag = Tag.find_or_create_by(name: tag_or_tag_name.to_s)
      end

      tags << the_tag if the_tag
    end
  end
end
