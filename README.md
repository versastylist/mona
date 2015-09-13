# Mona Readme

## Setting up development environment
Make sure to have postgres installed and running.  You should see an elephant in
top bar of your computer if its on.
```
rake db:create db:migrate db:test:prepare
```

Running the test suite:
```
rspec spec
```

## Workflow
### Pull Request & Branching
When checking out a branch use initials and then description of feature followed by
issue id.

Example:
```ruby
git checkout -b sd-setting-up-gemfile-2
```

This is assuming there is an issue #2 that should set up the Gemfile.

### Styling/CSS
Take advantage of the fact that SCSS allows you to use variables and mixins.
File structure for frontend and conventions:

```
app/assets/stylesheets
├── application.scss
├── components
│   └── nav.scss
├── mixins.scss
├── pages
│   └── home.scss
└── variables.scss
```

Disregard normal rails manifest and instead `import` all styles using SCSS.
Import in this order:
*  Framework/external libraries
*  Fonts
*  Variables
*  Mixins
*  Components
*  Page specific CSS

Page styling should be properly namespaced to the page using the
controller/action names.  There is a global helper method called `body_class`
which automatically appends the controller/action name as classes to the page.

Example:
If you're making styling changes for the `Homes#index` page:
```css
body.homes.index {
  .title {
    font-size: 2em;
    color: black;
  }
}
```
**Note**: all my css for that page should be inside the `body.homes.index`.
This will avoid name collisions and make life a lot easier.

**Components**
If you're working on css for a component of the website and not a specific page
make sure to put the styles inside the components folder.  For example, if
you're styling something for the `navbar` or maybe `buttons` make sure to put
that in the component folder.  Don't have the namespace for these styles since
you want them to be site wide and not specific to the page.  If you need to
override the button styles for a specific page than that belongs in the pages
scss file.

**Variables**
When using site wide settings make sure to set them as variables in the
`stylesheets/variables.scss` file.  For example if we had global colors and font
sizes we would do something like:

```scss
/* app/assets/stylesheets/variables.scss */

/* COLORS */
$primary-color:  #eee;
$secondary-color:  #999;

/* FONTS */
$paragraph-font-size: 1em;
$title-font-size: 2em;
```

**Mixins**
When you find yourself re-doing the same css 2 or 3 times make sure to extract
that functionality into a mixin that can be reused.
```scss
/* app/assets/stylesheets/mixins.scss */

@mixin background-and-hover($color, $percentage) {
  background: $color;
  &:hover {
    background: darken($color, $percentage);
  }
}
```

### Elastic Search

**Add searchkick to models you want to search.**

class User < ActiveRecord::Base
  searchkick
end

**Add data to the search index.**

Product.reindex

**Queries**

products = Product.search "apples"
products.each do |product|
  puts product.name
end

Query like SQL

Product.search "apples", where: {in_stock: true}, limit: 10, offset: 50

for more advanced queries, check <a href="https://github.com/ankane/searchkick#queries">Here</a>
