# -*- coding: utf8
import cherrypy
from jinja2 import Environment, FileSystemLoader
import os
from collections import defaultdict
from random import random
from cherrypy.lib.static import serve_file
import csv
import re

env = Environment(loader=FileSystemLoader('templates'))
current_dir = os.path.dirname(os.path.abspath(__file__))        

class Root:

    def __init__(self):

        self.points = points =  [int(x[0]) for x in csv.reader(open(os.path.join(current_dir, 'm.csv')),delimiter='\t')]
        self.speakers = speakers = [x[2].decode('utf8','ignore') for x in csv.reader(open(os.path.join(current_dir, 't.csv')),delimiter='\t')]        
        self.diputados = diputados = list(csv.reader(open(os.path.join(current_dir,'diputados.csv'))))
        self.match = match = [map(lambda x:x.strip().decode('utf8','ignore'),x.split(':')) for x in open(os.path.join(current_dir, 'match.srt'))]

        speaker_diputado = self.match_speakers(speakers,diputados)

        self.important_points = []
        segments = [x[1] for x in self.text_segments(os.path.join(current_dir,'x.txt'))]
        i=0; j=0; k=0;
        self.data = []
        while i<len(points) and j<len(speakers):
            if k < len(match):
                if int(match[k][0]) > points[i]:
                    self.data.append((points[i],None,None))
                    i += 1
                elif int(match[k][0]) == points[i]:
                    while j<len(speakers) and match[k][1] != speakers[j]:
                        self.data.append((None,speaker_diputado[j],segments[j]))
                        j += 1
                    if j<len(speakers):
                        self.data.append((points[i],speaker_diputado[j],segments[j]))
                    i += 1; j += 1; k += 1;
                else:
                    import ipdb; ipdb.set_trace()

    def match_speakers(self,speakers,diputados):
        ans = []
        i=0
        for spk in speakers:
            #if i==29:
            #    import ipdb; ipdb.set_trace()
            i += 1
            spk = spk.encode('utf-8') \
                .replace('á','A').replace('é','E').replace('í','I') \
                .replace('ó','O').replace('ú','U').replace('ü','U') \
                .replace('ñ','Ñ').upper()

            if spk.startswith('SECRETAR'):
                ans.append([None,None,None])
                continue

            nm = re.findall('\((.*)\)',spk)
            spk = re.sub('\((.*)\)','',spk).strip()
            initials = [x.strip()[0] for x in spk.split()]
            if len(nm)>0:
                initials.extend(x for x in nm[0] if x.isalpha())

            candidates = [x for x in diputados if x[0].split(',')[0].strip() == spk]
            if len(candidates) == 1:
                print "%s -> %s" % (spk,candidates[0][0])
                ans.append(candidates[0])
            else:
                for cand in candidates:
                    cand_initials = [x.strip()[0] for x in cand[0].replace(',',' ').split()]
                    if initials == cand_initials:
                        ans.append(cand)
                        print "%s -> %s" % (spk,cand[0])                        
                        break
                else:
                    print "Not found"
                    import ipdb; ipdb.set_trace()
        return ans


    def text_segments(self, fname):
        text = open(fname).read()
        x=re.split('(\n\s*\n|\n-[^\n]+\n)',text)
        segments = [t.strip() for t in x if t.strip().startswith('Sr') and not re.match('Sra?\. President.*',t.strip())]
        segments = map(lambda x:x.replace('\n','<br/><br/>'), segments)
        return [[x,x] for x in segments]

    def text_segments2(self, fname):
        text = open(fname).read()
        segments = []
        prev = 0
        prevperson = ""
        for m in re.finditer('\nSra?\. (.*)\.-',text):
            if 'President' in m.group(1): continue
            print m.start(),prev,m.group(1)
            #if m.start() - prev < 500 and len(segments) > 0:
            #    print "<pop>"
            #    segments.pop()
            ##if m.group(1) != prevperson:
            if len(segments)>0:
                segments[-1][1] = text[prev:m.start()]
            segments.append([m.group(1),None])
            prev = m.start()
            prevperson = m.group(1)

        print [x[0] for x in segments]
        print len(segments)
        return segments

    @cherrypy.expose
    def index(self):        
        tmpl = env.get_template('index.html')
        return tmpl.render(dict(points=self.points, speakers=self.speakers))

    @cherrypy.expose
    def index2(self):
        tmpl = env.get_template('index2.html')
        return tmpl.render(dict(data=self.data,important_points=self.important_points))

    @cherrypy.expose
    def play(self):
        tmpl = env.get_template('play.html')
        return tmpl.render(dict(data=self.data))

    @cherrypy.expose
    def video(self):        
        return serve_file(os.path.join(current_dir, "../prueba2/2/sesion_2013031301.mp4"), content_type='video/mpeg4')

conf = {'/css': {'tools.staticdir.on': True,
                 'tools.staticdir.dir': os.path.join(current_dir, 'css')},
        '/js': {'tools.staticdir.on': True,
                 'tools.staticdir.dir': os.path.join(current_dir, 'js')},
        '/img': {'tools.staticdir.on': True,
                 'tools.staticdir.dir': os.path.join(current_dir, 'img')}}

cherrypy.config.update({'server.socket_host': '0.0.0.0',
                        'server.socket_port': 8080,
                       })

cherrypy.quickstart(Root(),config=conf)
