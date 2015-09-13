## Mona Readme

### Setting up development environment
Make sure to have postgres installed and running.  You should see an elephant in
top bar of your computer if its on.  
```  
rake db:create db:migrate db:test:prepare  
```

Running the test suite:
```  
rspec spec  
```

### Workflow  
**Pull Request & Branching**  
When checking out a branch use initials and then description of feature followed by
issue id.

Example:
```ruby  
git checkout -b sd-setting-up-gemfile-2  
```  

This is assuming there is an issue #2 that should set up the Gemfile.  

**Styling/CSS**  
Take advantage of the fact that SCSS allows you to use variables and mixins.
File structure for frontend and conventions:

```  
app/assets/stylesheets
├── application.scss
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




