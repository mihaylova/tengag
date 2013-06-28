module ApplicationHelper
  def nav_link_to(name = nil, path = nil)
    content_tag :li, class: current_path?(path) do
      content_tag :a, href: path do
        name
      end
    end
  end

  def current_path?(path)
    current_path = full_path
    current_path.gsub(/\?.*/, '')

    'active' if path == current_path
  end

  def full_path
    request.fullpath
  end
end
