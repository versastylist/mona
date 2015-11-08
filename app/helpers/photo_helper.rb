module PhotoHelper
  def gallery(name, size, *photos)
    content_tag(:div, class: 'photo-gallery') do
      photos.each do |photo|
        link = link_to photo.image_url, class: 'photo-gallery-image', data: { lightbox: name, title: photo.description } do
                 image_tag photo.image_url(size)
               end
        concat(link)
      end
    end
  end
end
