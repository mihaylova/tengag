require 'spec_helper'

describe TagsController do
  let(:tag) { FactoryGirl.build(:tag) }

  describe "#index" do
    it "return all tags" do
      Tag.should_receive(:all).and_return([tag])
      visit tags_path
      within'.simple_form' do
        page.should have_content (tag.name)
      end 
    end
  end

  context 'should return posts' do
    let(:post) { FactoryGirl.create(:post) }
    before {post.tags << tag  }

    describe '#show' do
      its 'find posts whit current tag' do
        Tag.should_receive(:find_by_name).and_return(tag)
        visit tags_show_path(tag.name)
        page.should have_content (post.title)
      end
    end

    describe "#search" do
      its "return posts with selected tags" do
        Tag.stub(:where) { [tag] }
        Tag.stub(:all) { [tag] }
        #Post.any_instance.should_receive(:uniq).and_return([post])
        visit tags_path
        within'.simple_form' do
          check(tag.name)
          click_on ('Search')
        end 
        page.should have_content (post.title)
        
      end
    end
  end
end
