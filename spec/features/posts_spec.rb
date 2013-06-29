require 'spec_helper'

describe "Posts:" do
  let(:post) { FactoryGirl.build(:post, id: 1, created_at: DateTime.now, updated_at: DateTime.now) }
 
    it 'User can see posts' do
      Post.should_receive(:all).and_return([post])

      visit posts_path
      page.should have_content(post.title)
    end

    it 'User can see single post' do
      Post.should_receive(:find).and_return(post)

      visit post_path(post)
      page.should have_content(post.title)
    end

    it 'User can see hot posts' do
      Post.should_receive(:hot).and_return([post])

      visit hot_posts_path
      page.should have_content(post.title)
    end

    it 'User can see trending posts' do
      Post.should_receive(:trending).and_return([post])

      visit trending_posts_path
      page.should have_content(post.title)
    end


  context 'When user is logged' do 
    let(:user) { FactoryGirl.create(:user) }

    before :each do
      login_as(user, :scope => :user)
    end

    after(:each) { Warden.test_reset!  }

    context 'in single post page' do
      before { Post.should_receive(:find).and_return(post) }


      context 'form cuurent user' do
        before do
          post.user = user 
          visit post_path(post)
        end

        it 'can delete its own post' do
          within '.form-actions' do
            page.should have_content('Delete')
          end
        end

        it 'can edit its own post' do
          within '.form-actions' do
            page.should have_content('Edit')
           end
        end
      end

      context 'form other user' do
        before { visit post_path(post) }

        it 'can not delete post from other users' do
          within '.form-actions' do
            page.should_not have_content('Delete')
          end
        end

        it 'can not  edit post  from other users' do
          within '.form-actions' do
            page.should_not have_content('Edit')
          end
        end
      end
    end
    
    it 'can create post' do
      expect do
        visit new_post_path

        fill_in 'Title', with: "Some post title"
        image_path = Rails.root + 'app/assets/images/images.jpg'
        attach_file 'post_picture', image_path
        click_on 'Create Post'
      end.to change { Post.count }.by(1)
    end

    it 'can update post' do
      Post.should_receive(:find).exactly(3).times.and_return(post)
      # Post.any_instance.stub(:update_attributes) { true }
      # Post.any_instance.stub(:new_record?) { false }
      Post.any_instance.stub(update_attributes: true, new_record?: false)

      visit edit_post_path(post)
      click_on 'Update Post'

      page.current_path.should == post_path(post)
    end

    

  end

  context 'When user is not logged' do

    

    it 'can not create post' do
      visit new_post_path
      current_path.should == new_user_session_path
    end

    it 'can not update post' do
      Post.stub(:find) { post }
      visit edit_post_path(post)
      current_path.should == new_user_session_path
    end

     it 'can not modify posts' do
      Post.should_receive(:find).and_return(post)

      visit post_path(post)
      within '.form-actions' do
        page.should_not have_content('Delete')
        page.should_not have_content('Edit')
       
      end
    end


  end
end
