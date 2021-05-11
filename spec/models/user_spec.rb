require 'rails_helper'

RSpec.describe User, type: :model do

  NAMES = %w[ Odin Thor Loki Skurge ]
  TAGS  = %w[ asgardian frost_giant has_stuff ]

  NAMES.each do |name|
    let(name.downcase) { User.create(name: name) }
  end
  TAGS.each do |tag|
    let(tag.downcase) { Tag.create(name: tag) }
  end

  it "can be tagged with a Tag" do
    expect { odin.tag_with asgardian }.to \
      change { odin.tag_names } \
      .from( [] )
      .to( %w[ asgardian ] )
  end

  it "can be tagged with a string" do
    expect { odin.tag_with "asgardian" }.to \
      change { odin.tag_names } \
      .from( [] )
      .to( %w[ asgardian ] )
  end
end
