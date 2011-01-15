module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the homepage/
      '/'
    when /the new session page/
      '/compte/login'
    when /the new password page/
      '/compte/recover_password'
    when /the account page/
      '/compte'
    when /the new show page/
      '/compte/emission/create'
    when /the "(.*)" show page/
      show = Show.find_by_slug($1)
      "/compte/emission/show/#{show.id}"
    when /the edit "(.*)" show page/
      show = Show.find_by_slug($1)
      "/compte/emission/edit/#{show.id}"
    when /the edit "(.*)" show logo page/
      show = Show.find_by_slug($1)
      "/compte/emission/select_logo/#{show.id}"
    when /the new post page of "(.*)" show/
      show = Show.find_by_slug($1)
      new_admin_show_post_path(show)
    when /the posts page of "(.*)" show/
      show = Show.find_by_slug($1)
      admin_show_posts_path(show)
    when /the edit "(.*)" post page of "(.*)" show/
      show = Show.find_by_slug($2)
      post = show.posts.find_by_slug($1)

      edit_admin_show_post_path(show, post)
    when /the "(.*)" post page of "(.*)" show/
      show = Show.find_by_slug($2)
      post = show.posts.find_by_slug($1)
 
      admin_show_post_path(show, post)
    when /the posts page of "(.*)" show/
      show = Show.find_by_slug($1)
      admin_show_posts_path(show)
    when /the new image page of "(.*)" show/
      show = Show.find_by_slug($1)
      new_admin_show_image_path(show)
    when /the images page of "(.*)" show/
      show = Show.find_by_slug($1)
      admin_show_images_path(show)
    when /the "(.*)" image page of "(.*)" show/
      show = Show.find_by_slug($2)
      image = show.images.find_by_title($1)
      admin_show_image_path(show, image)

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
