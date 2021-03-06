#!/usr/bin/python
# -*- coding: utf-8 -*-

from requests_oauthlib import OAuth1
import requests
import json
import oauth2 as oauth
import urlparse

def main():

    # your app + API constants
    CONSUMER_KEY = '' # REGISTER AN APP WITH FITBIT AND UPDATE THIS
    CONSUMER_SECRET = '' # UPDATE THIS
    consumer = oauth.Consumer(CONSUMER_KEY, CONSUMER_SECRET)
    client = oauth.Client(consumer)
    REQUEST_TOKEN_URL = 'http://api.fitbit.com/oauth/request_token'
    ACCESS_TOKEN_URL = 'http://api.fitbit.com/oauth/access_token'
    AUTHORIZE_URL = 'http://www.fitbit.com/oauth/authorize'
    BASE_URL = 'https://api.fitbit.com'

    # request token
    resp, content = client.request(REQUEST_TOKEN_URL, "POST")
    if resp['status'] != '200':
        raise Exception("Invalid response %s." % resp['status'])     
    request_token = dict(urlparse.parse_qsl(content))

    print "Go to the following link in your browser:"
    print "%s?oauth_token=%s" % (AUTHORIZE_URL, request_token['oauth_token'])
    oauth_verifier = raw_input('Enter PIN from browser: ')


    token = oauth.Token(request_token['oauth_token'], request_token['oauth_token_secret'])
    token.set_verifier(oauth_verifier)
    client = oauth.Client(consumer, token)
     
    resp, content = client.request(ACCESS_TOKEN_URL, "POST")
    access_token = dict(urlparse.parse_qsl(content))

    auth = OAuth1(CONSUMER_KEY, CONSUMER_SECRET, access_token['oauth_token'], access_token['oauth_token_secret'])

    # UPDATE YOUR USER ID in each of the following three lines
    caloriesIn_json = requests.get("http://api.fitbit.com/1/user/<yourUserID>/foods/log/caloriesIn/date/2013-08-31/max.json", auth=auth)
    sleep_json = requests.get("http://api.fitbit.com/1/user/<yourUserID>/sleep/minutesAsleep/date/2013-08-31/max.json", auth=auth)
    caloriesOut_json = requests.get("http://api.fitbit.com/1/user/<yourUserID>/activities/calories/date/2013-08-31/max.json", auth=auth)

    caloriesIn = json.loads(caloriesIn_json.text)
    caloriesIn_list = [int(item['value'].encode('utf-8')) for item in caloriesIn['foods-log-caloriesIn'] if int(item['value'].encode('utf-8')) > 0]
    avgCaloriesIn = sum(caloriesIn_list) / len(caloriesIn_list)

    caloriesOut = json.loads(caloriesOut_json.text)
    caloriesOut_list = [int(item['value'].encode('utf-8')) for item in caloriesOut['activities-calories'] if int(item['value'].encode('utf-8')) > 0]
    avgCaloriesOut = sum(caloriesOut_list) / len(caloriesOut_list)

    sleep = json.loads(sleep_json.text)
    sleep_list = [int(item['value'].encode('utf-8')) for item in sleep['sleep-minutesAsleep'] if int(item['value'].encode('utf-8')) > 0]
    avgSleep = (sum(sleep_list) / float(len(sleep_list))) / 60

    with open('fitbitCaloriesIn.json', 'w') as outfile:
        json.dump(caloriesIn, outfile)
    with open('fitbitCaloriesOut.json', 'w') as outfile:
        json.dump(caloriesOut, outfile)
    with open('fitbitSleep.json', 'w') as outfile:
        json.dump(sleep, outfile)

    print "Average Calories eaten: %i" % avgCaloriesIn
    print "Average Calories burned: %i" % avgCaloriesOut
    print "Average hours slept: %.2f" % avgSleep


if __name__ == '__main__':
    main()
