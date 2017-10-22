## Synopsis

Bloc's API provides an external facing JSON Web Token authorized gateway to the Bloc application. You can access it via cURL, but an API client can manage the low-level details of making requests and handling responses. Build the Kele API Client to provide easy access to and use of the student endpoints of Bloc's API.

## Code Example

      ~/p/kele ❯❯❯ irb
       > require './lib/kele.rb'
        => true
       > Kele.new("jane@gmail.com", "abc123")


## API Reference

Bloc's base API URL: https://www.bloc.io/api/v1