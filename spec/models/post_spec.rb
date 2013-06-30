require 'spec_helper'

describe Post do
  it { should belong_to(:user) }
  xit { should have_attached_file(:picture) }
  it { should validate_attachment_presence(:picture) }
  it { should validate_presence_of(:title) }
  it { should validate_attachment_content_type(:picture).allowing('image/jpeg', 'image/png', 'image/gif') }
  it { should validate_attachment_size(:picture).less_than(1.megabytes) }
  it { should have_and_belong_to_many(:tags) }
end
