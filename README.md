## README

Notes on the code:
- 4/6
  - I set up MongoDB using Mongoid (http://mongoid.org/en/mongoid/). A little worried that it might not work for other people's, so let me know if it doesn't work for you. To test it out, first run bundle update to install the gem. Then run the command "mongod" in one terminal tab/window. Run "rails console" or "rails c" in another. In the rails console, type Recipe.count. If it returns a number (the number of Recipes in the database), it works, if not, there's something wrong.
- Old:
  - To setup up a page's title, write <% provide(:title, "Page Title") %> at the top of the html file. This will set the page's title to "Page Title | Mixr"
  - For elements that should appear on all pages (e.g. header, footer, navbar), it's easiest to add them to app/views/layouts/application.html.erb. They'll be rendered on every page and then the code that is specific to that page will be inserted where it says "<%= yield %>" in application.html.erb

Some good Rails resources:
- Rails Tutorial www.railstutorial.org
- RailsGuides http://guides.rubyonrails.org/

Software:
- zeus https://github.com/burke/zeus
  - alternative to using rails server, rails console, etc. runs faster because it preloads the rails app (this can also mean that sometimes it doesn't register all updates you make to the code, so occasionally you have to Ctrl-X out of it and restart it, but it usually does a pretty good job)

