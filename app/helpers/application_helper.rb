module ApplicationHelper
  class RequestCurrentPath
    def initialize(fullpath)
      fullpath.gsub(/\?.*/, '')
      @current_path = fullpath
    end

    def active?(path)
      'active' if path == @current_path
    end
  end

  def nav_link_to(name = nil, path = nil)
    @request_path ||= RequestCurrentPath.new(request.fullpath)

    content_tag :li, class: @request_path.active?(path) do
      content_tag :a, href: path do
        name
      end
    end
  end
end
