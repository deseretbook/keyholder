# Keyholder

A simple gem to enable our brand of request authentication easily.

## Installation

Add this line to your application's Gemfile:

    gem 'keyholder'

And then execute:

    $ bundle

## Terms
* request server - server making the api request
* api server - server receiving the api request. should contain an authenticating record.

## Usage on request server

A request will look like this:
```
http://apihost.com/endpoint?signature=SIGNATURE&timestamp=TIMESTAMP&key=KEY
```

request parameters:
```
signature - a string generated from the current timestamp and the private token that will be matched on the api server. generate like this: Digest::SHA1.hexdigest(TIMESTAMP.to_i.to_s + PRIVATE_TOKEN)
```
```
timestamp - a timestamp integer that is generated on the request server at the time of request. generate like this: Time.now.to_i
```
```
key - what you will use to find the authenticating record on the api server. this should be stored in an environment variable or something like it.
```


## Usage on api server

You will need to set up an authenticating record in the app you want to hit and add two things to it:
* key - this is public. it can be generated like this: `Keyholder.generate_key`
* token - this should be kept private. it is only sent when encrypted. it can be generated like this: `Keyholder.generate_token`

First verify the key is correct by finding the authenticating record on the api server:
```
record = Record.find_by_key(params[:key])
halt if !record
```

Next authenticate the request using the timestamp and signature:
```
Keyholder.authenticate_request(params[:signature], params[:timestamp], record.token)
```




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
