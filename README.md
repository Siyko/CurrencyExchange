# README

TROUBLES
1-fixer.io API only allows to use /latest and /{date} endpoints without payment + have monthly requests limit(1000) which is not enough to finish task.
2-exchangeratesapi.io - is free, but somehow doesn't work properly(not returning all days from the period)

General description
1-default devise+google_oauth2 signup/login
2-service which makes API calls is in /service folder
3-chartkick for chart

Possible improvements and fixes
1-Need to add decorator, because view's code is really ugly.
2-Create 'ExchangeBuilder' to make exchanges_controller.rb#create look better.
3-Response is saved as json in DB, so if API changes it will not work correctly(but if we use relative model it won't work anyway to, so i think json is better). Usage of NOSQL DB is unreasonable for this small project.
4-No errorproof or reasonable logging for now, any API failure will cause crash.
5-Possible bottleneck: making API call inside web request. If request will take too long and few users will do this it will make app unresponsible. So move API call to background job or microservice.
6-Tests. Nuff said.
7-Refactoring/renaming/todos described in code comment's too.
