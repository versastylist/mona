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

**Mailers/Mailcatcher**  

In development in order to 'catch' the emails that would normally be sent out
you need to activate a daemon called `mailcatcher`.  Open a tab in your terminal
and type: `mailcatcher` (after you bundle install) and it should be up and
running.  Open a tab in browser and go to: `http://localhost:1080/` in order to
see the emails that would be sent.

**Elastic Search**  

For development you also need an elastic search server running in the
background.

To install elastic search first download via your favorite package manager.  For
homebrew:  

```  
brew install elasticsearch
```
Then this is the command to get it running:  

```
elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
```

I have that command saved in an alias in my `.zshrc` file to save time:  
```
# .zshrc file
alias elsearch='elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml'
```

**Stripe Credentials**
[Go here to get test CC's and Bank Account Info](https://stripe.com/docs/testing)

### Rake Tasks
There is a rake task that gets scheduled to handle all payment processing.  The
rake task is called: `rake payments:process`

There is also a rake task to help with the creation of the client/stylist
registration surveys called: `rake survey:registrations`


## Workflow  
### Pull Request & Branching  
When checking out a branch use initials, issue ID, and then description of
feature.  

Example:
```ruby  
git checkout -b sd-2-setting-up-gemfile  
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
