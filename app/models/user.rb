class User < ApplicationRecord
  has_many :usertags
  has_many :tags, through: :usertags

  def tag_names
    tags.map(&:name).sort
  end

  def tag_with(*tags_or_tag_names)
    tags_or_tag_names.flatten.each do |tag_or_tag_name|
      case tag_or_tag_name
      when Tag
        the_tag = tag_or_tag_name
      when String, Symbol
        the_tag = Tag.find_or_create_by(name: tag_or_tag_name.to_s)
      end

      tags << the_tag if the_tag
    end
  end

  def similarly_tagged_users
    sql = <<~SQL
      SELECT u.*, COALESCE(matching_tag_counts.n, 0) AS similarity_score
      FROM users AS u
        LEFT OUTER JOIN (
          SELECT user_id, COUNT(*) AS n
          FROM usertags
          WHERE tag_id IN(#{tag_ids.join(",")})
          GROUP BY user_id
        ) AS matching_tag_counts ON u.id=matching_tag_counts.user_id
      WHERE u.id != #{id}
      ORDER BY similarity_score DESC, u.name ASC
    SQL
    self.class.find_by_sql(sql)
  end

  def inspect
    "<#{name}>"
  end
end
