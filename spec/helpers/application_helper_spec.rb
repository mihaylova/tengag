require 'spec_helper'

describe ApplicationHelper do
  describe "nav_link_to" do
    let(:name) { 'root path' }
    let(:path) { '/some/path' }


    its 'return link with active class' do
      helper.stub(full_path: path)

      link = helper.nav_link_to(name, path)
      expected = "<li class=\"active\"><a href=\"#{path}\">#{name}</a></li>"

      link.should eq expected
    end

    its "return link without active class" do
      helper.stub(full_path: 'not_exisiting')

      link = helper.nav_link_to(name, path)
      expected = "<li><a href=\"#{path}\">#{name}</a></li>"
      
      link.should eq expected
    end

  end
end
