Hostname "{{ HOST_NAME | default(HOSTNAME) }}"
FQDNLookup false
Interval 10
Timeout 2
ReadThreads 10
WriteThreads 10
# Avoid memory issue if one of the write plugins is slow (e.g. graphite)
WriteQueueLimitHigh 250000
WriteQueueLimitLow 250000

LoadPlugin contextswitch
LoadPlugin cpu
LoadPlugin df
LoadPlugin interface
LoadPlugin load
LoadPlugin memory
LoadPlugin tcpconns
LoadPlugin uptime

<Plugin df>
        FSType "rootfs"
        IgnoreSelected true
        ReportByDevice false
        ReportInodes true
        ReportReserved true
</Plugin>

<LoadPlugin "python">
    Globals true
</LoadPlugin>

<Plugin "python">
    ModulePath "/usr/share/collectd/collectd-haproxy"

    Import "haproxy"

    <Module "haproxy">
        Socket "haproxy:1999"
        Interval 10
        #pxname or svname to monitor
        ProxyMonitor "http-backend"
        ProxyMonitor "backend"
        EnhancedMetrics 'False'
        # ExcludeMetric 'session_limit'
        # ExcludeMetric 'response_1xx'
    </Module>
</Plugin>


<Include "/etc/collectd/collectd.conf.d">
    Filter "*.conf"
</Include>
