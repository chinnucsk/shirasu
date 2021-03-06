What's this
===========

Shirasu.ws is a WebSocket server framework.

Require
=======

- Erlang R14B
- Erlang - System Application Support Libraries (SASL)
- misultin 0.9-dev higher
- mochiweb
- Python 2.x >= 2.6
- PyYAML

If you use WebSocket protocol hybi-10, required misultin 0.9-dev higher.

Quick start
===========

Install and boot for Fedora 14::

  $ sudo yum install -y PyYAML erlang-erlsyslog erlang-misultin erlang-mochiweb erlang-sasl
  $ sudo rpm -ivh http://shirasu.googlecode.com/files/shirasu-0.2-1.fc14.i386.rpm
  $ sudo service shirasu start

and access to demonstration that is listening at 8000 port.
ex) http://localhost:8000/index.html

Include in the demonstration:

- Chat
- Exchange Chart
- Twitter Streaming
- Stats
- Commandline Monitor
- Network Monitor

If you use `Network Monitor`, require some Python libraries ::

  $ mkvirtualenv pingman
  $ workon pingman
  $ pip install -r rel/files/sample/scripts/pingman.packages.txt

You can configure the Shirasu.ws by editing YAML file.
ex) `/etc/shirasu/shirasu.yaml`::

  shirasu:
    - port: 8000

  shirasu_stat:
    /stat: true

  shirasu_http_serve:
    /: /var/lib/shirasu/sample/www

  shirasu_http_stream:
    /stream.twitter.com/1/statuses/sample.json: "http://<SCREEN_NAME>:<PASSWORD>@stream.twitter.com/1/statuses/sample.json"
    /exchange/USDJPY:
    - "http://chartapi.finance.yahoo.com/instrument/1.0/USDJPY=X/chartdata;type=quote;range=2d/csv/"

  shirasu_commandline:
    /commandline/traceroute: "traceroute google.com"
    /commandline/ping:
    - "ping -c  5 localhost"
    - "ping -c 10 localhost"

Boot from source of develop version::

  $ git clone git://github.com/MiCHiLU/shirasu.git
  $ cd shirasu
  $ git checkout dev
  $ make debug

.. image:: https://secure.travis-ci.org/MiCHiLU/shirasu.png?branch=dev

Features
========

WebSocket
---------

- draft-ietf-hybi-thewebsocketprotocol-10
- path based channel

Basic
-----

- provide RPM_ package for Fedora 14
- YAML config
- serve static files via HTTP
- syslog support

.. _RPM: http://code.google.com/p/shirasu/downloads/list?can=3

Proxy
-----

- response body of HTTP GET request over WebSocket

Bundles
-------

- sample code

Performance
===========

shirasu is used misultin that is an Erlang library for building fast lightweight HTTP servers.
(see https://github.com/ostinelli/misultin)

How to use syslog
=================

enable to provides UDP syslog reception.
edit `/etc/rsyslog.conf`::

  $ModLoad imudp.so
  $UDPServerRun 514

add rules to `/etc/rsyslog.conf`::

  user.*    /var/log/shirasu/shirasu.log

..  $template MyTemplateName,"/var/log/syslog/%hostname%/%$year%/%$month%/%$day%/%programname%.log"
..  user.*  ?MyTemplateName

and restart rsyslog::

  $ sudo service rsyslog restart

How to build RPM package
========================

checkout from Shiwasu.ws repository, and build RPM package::

  $ git clone git://github.com/MiCHiLU/shirasu.git
  $ cd shirasu
  $ git checkout shirasu-0.2
  $ make dist
  $ RELEASE=1 make package

When used in fedora 14, You can reduce the package size.
Use this command instead of `$ make dist`::

  $ make dist4fedora

finally, see your `package/packages` direcroty.

Changelog
=========

0.3dev:
  - changed the format of listening port in YAML file
  - added SSL support for WebSocket
  - support input from system commandline

0.2:
  - supported syslog
  - added status module

0.1.2:
  - fixed list of RPM requires

0.1.1:
  - included sample files

0.1:
  - first build
