# Mock Response
[![Code Climate](https://codeclimate.com/github/matthewcrist/mock-response.png)](https://codeclimate.com/github/matthewcrist/mock-response) [![Build Status](https://travis-ci.org/matthewcrist/mock-response.png?branch=master)](https://travis-ci.org/matthewcrist/mock-response) [![Dependency Status](https://gemnasium.com/matthewcrist/mock-response.png)](https://gemnasium.com/matthewcrist/mock-response)

Sometimes in the course of development you may need to mock HTTP responses. This is a simple service to return various HTTP responses.

To call each error, simply append the response that you would like returned to the end of this sites URL, like so:

http://mock.isssues.com/{RESPONSE}

These responses are supported and can be called using these HTTP verbs: **GET**, **POST**, **PUT**, **DELETE**, **OPTIONS**, and **PATCH**.

If something is missing-like tests-drop me a line at hello@uncluttah.com or fork the repo and submit a pull request.

## Installation

To get this up and running, first clone the repo. Once you have it, in your sell do this:

```sh
bundle install
bundle exec unicorn
```

That's it.

## Testing

You can run the test suite with 

```sh
rake spec
```

## Timeout & Hesitation

Timeout and hesitation are configurable via ENV variables. In your environment change these to whatever you'd like.

```sh
MOCK_HESITATE=5
MOCK_TIMEOUT=28
```
