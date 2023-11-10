module ApplicationHelper
  def yesno(bool)
    if bool
      "Yes"
    else
      "No"
    end
  end

  # From https://www.writesoftwarewell.com/how-to-render-svg-icons-in-rails/
  def render_icon(icon, classes: nil)
    classes ||= ""
    render "icons/#{icon}", classes:
  end
end
