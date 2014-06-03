# Gametime

## Description

A group and and exercise app for improvisors.

## Geting Started
Command line:
```
git clone https://github.com/kthffmn/gametime.git
cd gametime
bundle install
rake db:migrate
rake db:seed
```
Becuase the gem hasn't been updated to require assets as Rails 4 specifies, in the 'chosen' gem, specifically in `stylesheets/chosen.css.scss`, add:
```
//= depend_on_asset "chosen-sprite.png"
//= depend_on_asset "chosen-sprite@2x.png"
```
To access the console run ommand line, run `rails c`, and to run the server, run `rails s`. In the browser go to `http://localhost:3000/`.

## Database

![Picture of database schema](https://raw.githubusercontent.com/kthffmn/gametime/master/public/img/database_schema.png)

## To Do (3 sections)

### 1. Rails
* ~~Make strong_params allow for users to make a new tag from game form~~
* ~~Add way to add multiple tags to game form~~
* ~~Fix now screwed up coffeescript for new game form~~
* ~~Make [active links in nav-bar appear active](http://stackoverflow.com/questions/9862524/twitter-bootstrap-pills-with-rails-3-2-2)~~
* ~~Beta branch: Fix bug where entering a negative number into min and max breaks the app resulting in a "can't use map with nil class" (also seen in 2 rspec failures) error~~
* Make homepage
* Add a [Wrap Bootstrap](https://wrapbootstrap.com/themes) theme
* Add variations to game form
* Add tips to game form
* Add search feature for faster browsing
* Add users that authenticate through [Facebook](http://railscasts.com/episodes/360-facebook-authentication)
* Use users' FB profile photos for their profiles
* Add "like" functionality to games

### 2. Angular
* Style angular
* Fix navbar in Angular view so that it's responsive, [seems to be an error in event propogation](https://github.com/angular/angular.js/issues/1674)
* Make links in nav-bar active when appropriate in Angular, see [StackOverflow's solution](http://stackoverflow.com/questions/16199418/how-do-i-implement-the-bootstrap-navbar-active-class-with-angular-js)
* Add other methods to order/search through results (by tag, popularity, etc.)

### 3. General
* Make [icon](http://designexemplars.files.wordpress.com/2011/06/thonet-bentwood-chair.jpg)
* Decide on name
* Santize scraped data [here](https://github.com/kthffmn/sanitization_practice) and make it into a seed file

## License

This app is MIT Licensed. See LICENSE for details.
