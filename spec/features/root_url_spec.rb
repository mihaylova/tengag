require 'spec_helper'

describe "Root URL" do
  it 'body should eq to posts#hot body'do
    visit hot_posts_path
    posts_body = page.body
    
    visit root_path
    page.body.should eq posts_body
  end
end
