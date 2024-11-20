module ApplicationHelper
  def asset_exists?(filename)
    # Check if either .jpg or .png exists
    extensions = ['.jpg', '.png']
    extensions.any? do |ext|
      File.exist?(Rails.root.join("app/assets/images/#{filename}#{ext}"))
    end
  end
end
