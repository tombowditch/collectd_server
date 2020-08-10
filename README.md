# collectd docker image

Very basic Docker image for one use: receive data from external collectd instances (on port 25899), write them to RRDs (volume on /var/lib/collectd/rrd) and forward them to `statsd_exporter:25598`.


