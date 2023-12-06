modules = {
  'hints > iterate',
  'http'
}

net.listen('0.0.0.0', 53, {kind = 'dns'})
net.listen('0.0.0.0', 443, {kind = 'doh2'})
net.listen('0.0.0.0', 853, {kind = 'tls'})
net.listen('0.0.0.0', 8453, {kind = 'webmgmt'})

log_level('info')
-- log_level('debug')
hints.add_hosts('/etc/knot-resolver/hosts.static')
cache.open(2 * GB, 'lmdb:///var/cache/knot-resolver')

print(cache.current_storage)
print(cache.current_size)
