#!/bin/bash
envtpl /etc/collectd/collectd.conf.d/write_graphite.conf.tpl
envtpl /etc/collectd/collectd.conf.tpl
/usr/bin/supervisord
