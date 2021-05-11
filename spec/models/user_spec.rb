require 'rails_helper'

RSpec.describe User, type: :model do

  NAMES = %w[ Odin Thor Loki Skurge ]
  NAMES.each do |name|
    let(name.downcase) { User.create(name: name) }
  end

  it "can be tagged with a Tag" do
    asgardian = Tag.create(name: "asgardian")
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

  describe "#similarly_tagged_users" do
    before do
      odin.tag_with   %w[ asgardian royalty ]
      thor.tag_with   %w[ asgardian royalty ]
      loki.tag_with   %w[ frost_giant royalty ]
      skurge.tag_with %w[ asgardian has_stuff ]
    end

    it "returns a list of users who are most similar to the target" do
      expect( odin.similarly_tagged_users   ).to eq( [ thor, loki, skurge ] )
      expect( thor.similarly_tagged_users   ).to eq( [ odin, loki, skurge ] )
      expect( loki.similarly_tagged_users   ).to eq( [ odin, thor, skurge ] )
      expect( skurge.similarly_tagged_users ).to eq( [ odin, thor, loki ] )
    end
  end
end
