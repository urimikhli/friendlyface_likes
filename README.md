# Friendface

## Project Description

Implement a JSON REST-style API that analyzes data from Friendface, a totally
legit social media platform.

## Instructions

* Fulfill the requirements below. When done please send us a zip of the git repo

## Requirements

* Tools are up to you. Add whatever gems you find useful.

* Friendface is a little behind the times so its API serves data in CSV instead
  of JSON. The accompanying [friendface.csv](https://gist.github.com/dabobert/4a31d09d20988ef0f128a6be57fa60d0) (located in the root of the app) file contains data
  about the "likes" that your posts have received.

* Ingest the CSV and expose four REST-style `GET` routes that return the following data:

    * Your most popular post(s)

    * Your biggest fan(s) (the person who has "liked" your posts the most times)

    * The day(s) of the week when you got the most "likes"


* The actual schema of the returned JSON doesn’t really matter as long
  as it represents the data in a clear manner to any client that might consume
  your API.

* There are no requirements around data persistence. Whether you use a real
  database, an in-memory database, an in-memory data structure, or have no
  persistence at all is up to you.  But if you use a database please use SQLite

* Please leave comments in places where you weren’t quite sure if you
  were solving the problem correctly to let us know that you've thought about it
  and made a conscious decision.

* Down below please provide working instructions for how to run your application and
  make sure that the application will actually run on someone else’s machine.

## Extra Credit 
* Write some tests for your logic. Test wherever/whatever the majority of the code lives

## Write Instructions Below:
* Make sure to also leave a sample woring url for every endpoint you implement

##  API Doc

### Requests

- popular posts: `/liks/popular_posts`
- biggest fans:  `/liks/biggest_fans`
- popular days of the week:  `/liks/popular_days`

### Response json
- popular posts: In descending order of popularity(number_of_likes): `[ {:postId => number_of_likes}, {...} ]`

  e.g.`[{1=>4}, {2=>2}, {3=>2}, {4=>2}]`

- biggest fans: In descending order of total number of likes per fan: `[ {:user => number_of_likes}, {...} ]`

  e.g. `[{"lane"=>4}, {"jane"=>3}, {"georg"=>2}, {"bob"=>1}]`

- popular days of the week: In descending order of total number of likes per day of the week: `[ {:DayOfWeek => number_of_likes}, {...} ]`

  e.g. `[{"Thursday"=>4}, {"Friday"=>3}, {"Tuesday"=>2}, {"Sunday"=>1}, {"Saturday"=>0}, {"Wednesday"=>0}, {"Monday"=>0}`


### Notes

- Tried to use jsonapi(https://jsonapi.org/) so it can be self documenting. I got it working, but it wouldn't format to the jsonapi standard and I gave up.

- I'm Using a simple rake task to inject the generic csv. This ideally should be done via an API call to the (imaginary) friendlyface api. Something like(w/o auth for now) `/poster/:id/likes/` and have it be ready to consume and save the csv response to the DB.

- I went with simple for the excercise so didnt add a Poster model. To make this more real I would Add a Poster model so that we can explicitly show our 'like' aggregation data for a specific poster. Something like `/poster/:id/likes/popular_posts`

- Ignored Auth for the purpose of the excercise 


