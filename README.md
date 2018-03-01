# Peafowl
[![Build Status](https://travis-ci.org/AliSepehri/peafowl.svg?branch=master)](https://travis-ci.org/AliSepehri/peafowl)

Where do I put my application's business logic? I don't like to write business logics in rails' models or controllers. Peafowl encapsulate your business logic as a peafowl.


## Installation
Add `peafowl` to your Gemfile and `bundle install`:

``` ruby
gem 'peafowl'
```

## Getting Started
In addition to [Interactor](https://github.com/collectiveidea/interactor) gem features, Peafowl support input validation. It is recommended that read Interactor gem before using Peafowl.

Peafowl use ActiveModel to provide validation for inputs. Following example shows a simple login service in Peafowl: 

``` ruby
class LoginService
  include Peafowl

  attribute :username, String
  attribute :password, String

  validates :username, presence: true
  validates :password, presence: true

  def call
    sample_username = 'misugi'.freeze
    sample_password = 'captain_tsubasa'.freeze

    add_error!('Username or Password is not valid!') unless username == sample_username && password == sample_password

    context[:user] = { username: sample_username }
  end
end
```

And now you can use your service:
``` ruby
result = LoginService.call(username: 'misugi', password: 'captain_tsubasa')

raise UnauthorizedException.new(result.errors) if result.failure?

current_user = result.user
```
### Input Parameters
You should define your input parameters with `attribute` keyword:

``` ruby
attribute param_name, String
```
`String` is parameter type and Peafowl will cast the passed argument to specified type (by [Virtus](https://github.com/solnic/virtus) gem).

### `add_error` and `add_error!` Methods
Peafowl services returns array of string as error messages. `add_error` and `add_error!` get a string or array of string as argument.

`add_error` method adds error(s) to error list and does not break service execution. After end of execution `failure?` method will return `true` (and `success?` will return `false`).

``` ruby
add_error('Your error message.') if condition
```

`add_error!` is same as add_error with the difference that add_error! will break the execution of call method.

## Why `Peafowl`?

Every gem which has been compared in
[this article](http://neethack.com/2015/06/rails-abstraction-showcase/) has some drawbacks. I like `active_interaction` but it isn't flexible and doesn't support composition. `interactor` is very simple one with a flexible structure but doesn't support input validation. 

Here are some advantages of Peafowl:
- Input validation
- Composition
- Simple error handling
- Readability, simplicity & flexibility


## Todo
- Output validation
- Input type validation
- Better error handling