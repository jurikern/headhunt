class ContentPage < ActiveRecord::Base
  belongs_to :contentable, polymorphic: true

  attr_accessible :html

  def self.build(user, context)
    content_page = user.content_page
    content_page = user.build_content_page if content_page.nil?

    content_page.html = context.render_to_string('content_pages/build_user_page', layout: false, :locals => { user: user })
    content_page.save
  end
end
