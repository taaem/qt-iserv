#!/usr/bin/env python
# -*- coding: utf-8 -*-
from html.parser import HTMLParser
import urllib
import http.cookiejar
import string
import os
import pyotherside

def get_data(u_name, u_password):
    cj = http.cookiejar.CookieJar()
    opener = urllib.request.build_opener(urllib.request.HTTPCookieProcessor(cj))

    url = 'https://ohmoor.de/idesk/'
    values = {"login_act": u_name, "login_pwd": u_password}
    headers = {'Content-type': 'application/x-www-form-urlencoded'}

    datas = urllib.parse.urlencode(values)
    data = datas.encode('utf-8')

    req = urllib.request.Request(url=url, data=data, headers=headers)
    response = opener.open(req)



    url = 'https://ohmoor.de/idesk/plan/index.php/Vertretungsplan/'
    req = urllib.request.Request(url=url)
    response = opener.open(req)
    content = response.read()



    htmlData = content.decode('latin-1')

    htmlArr = htmlData.split(os.linesep)


    #liste = [{}]
    list = []
    info = []


    class MyHTMLParser(HTMLParser):
        def __init__(self):
            HTMLParser.__init__(self)
            self.liste = [{}]
            self.counter = 0
            self.counter2FirstEntrys = 0
            self.endfile = 0
            self.parseData = 0
            self.gotDate = 0
            self.date = ""

        def handle_starttag(self, tag, attrs):
            if attrs == [('class', 'mon_title')]:
                self.gotDate = 1
                pass
            if attrs == [('class', 'mon_list')]:
                self.parseData = 1

        def handle_data(self, data):

            if self.gotDate == 1:
                pyotherside.send('date_received', data)
                pass
            if self.counter2FirstEntrys > 14 and self.parseData == 1 and data != '\n' and data != '' and data != '\r' and self.endfile == 0:
                if self.counter == 0:
                    self.liste[0]["klasse"] = data
                    self.counter = self.counter + 1
                elif self.counter == 1:
                    self.liste[0]["stunde"] = data
                    self.counter = self.counter + 1
                elif self.counter == 2:
                    self.liste[0]["vertreter"] = data
                    self.counter = self.counter + 1
                elif self.counter == 3:
                    self.liste[0]["lehrer"] = data
                    self.counter = self.counter + 1
                elif self.counter == 4:
                    self.liste[0]["fach"] = data
                    self.counter = self.counter + 1
                elif self.counter == 5:
                    self.liste[0]["normRaum"] = data
                    self.counter = self.counter + 1
                elif self.counter == 6:
                    self.liste[0]["raum"] = data
                    self.counter = self.counter + 1
                elif self.counter == 7:
                    self.liste[0]["info"] = data
                    self.counter = self.counter + 1
                pass
            if self.parseData == 1:
                self.counter2FirstEntrys = self.counter2FirstEntrys + 1


        def handle_endtag(self, tag):
            if self.parseData == 1 and tag == "table":
                self.endfile = 1
                self.parseData = 0
            if self.gotDate == 1 and tag == "div":
                self.gotDate = 0
                pass

    parser = MyHTMLParser()

    for line in htmlArr:
        parser.feed(line)
        liste = parser.liste
        if parser.liste != [{}]:
            list.append(parser.liste)
            pass

        parser.liste = [{}]
        parser.counter = 0
        pass

    return list
