#!/usr/bin/env python

import httplib
import urllib
import json
import os


def po_message():
    conn = httplib.HTTPSConnection("api.pushover.net:443")
    conn.request("POST", "/1/messages.json",
                 urllib.urlencode({
                     "token": os.environ.get('PUSHOVER_TOKEN'),
                     "user": os.environ.get('PUSHOVER_USER'),
                     "title": os.environ.get('PUSH_TITLE'),
                     "priority": os.environ.get('PUSH_PRIORITY'),
                     "message": os.environ.get('PUSH_MESSAGE'),
                 }), {"Content-type": "application/x-www-form-urlencoded"})
    return conn.getresponse()


def pb_message():
    conn = httplib.HTTPSConnection("api.pushbullet.com:443")
    conn.request("POST", "/v2/pushes",
                 json.dumps({
                     "type": "note",
                     "title": os.environ.get('PUSH_TITLE'),
                     "body": os.environ.get('PUSH_MESSAGE'),
                 }), {"Content-Type": "application/json",
                      "Access-Token": os.environ.get('PUSHBULLET_TOKEN')})
    return conn.getresponse()


def slack_message():
    conn = httplib.HTTPSConnection("hooks.slack.com:443")
    conn.request("POST", "/services/" + os.environ.get('SLACK_URL'),
                 json.dumps({
                     "text": os.environ.get('PUSH_TITLE') + "\n  => " + os.environ.get('PUSH_MESSAGE')
                 }))
    return conn.getresponse()


def wtf(msg):
    with open('/tmp/mylog.log', 'a') as f:
        f.write("W00T: %s - %s - %s - %s\n" % (os.environ.get('PUSH_TITLE'), os.environ.get('EMAIL'), os.environ.get('PUSHBULLET_TOKEN'), msg))
    return msg

if __name__ == "__main__":
    if os.environ.get('PUSH_TYPE') == "pushover":
        output = po_message().read()
    elif os.environ.get('PUSH_TYPE') == "pushbullet":
        output = pb_message().read()
    elif os.environ.get('PUSH_TYPE') == "slack":
        output = slack_message().read()
    else:
        output = os.environ.get('PUSH_TYPE') + " unknown"
    print wtf(output)
