const sh = require('shelljs')
const fs = require('fs')
const { join } = require('path')

const _exec = process.env.DEBUG ? console.info : sh.exec

const dnsmasqTmpl = require('./templates/dnsmasq')
const mongodbTmpl = require('./templates/mongodb')
const nginxTmpl   = require('./templates/nginx')
const redisTmpl   = require('./templates/redis')

const dnsmasq = (cfg, target, homebrew) => {
  (!fs.existsSync(join(target, 'dnsmasq'))) &&
    fs.mkdirSync(join(target, 'dnsmasq'))
  fs.writeFileSync(join(target, 'dnsmasq/dnsmasq.conf'), dnsmasqTmpl(cfg.context), 'utf8')
  _exec(`mv ${homebrew}/dnsmasq.conf ${homebrew}/dnsmasq-original.conf `)
  _exec(`ln -sf $(pwd)/config/dnsmasq/dnsmasq.conf ${homebrew}/dnsmasq.conf`)
  return true
}

const mongodb = (cfg, target, homebrew) => {
  (!fs.existsSync(join(target, 'mongodb'))) &&
    fs.mkdirSync(join(target, 'mongodb'))

  ;['databases', 'log'].forEach(item =>
    (!fs.existsSync(join(target, 'mongodb', item))) && fs.mkdirSync(join(target, 'mongodb', item)))

  fs.writeFileSync(join(target, 'mongodb/mongod.conf'), mongodbTmpl(cfg.context), 'utf8')
  _exec(`mv ${homebrew}/mongod.conf ${homebrew}/mongod-original.conf`)
  _exec(`ln -sf $(pwd)/config/mongodb/mongod.conf ${homebrew}/mongod.conf`)
  return true
}

const nginx = (cfg, target, homebrew) => {
  (!fs.existsSync(join(target, 'nginx'))) &&
    fs.mkdirSync(join(target, 'nginx'))

  ;['cache', 'logs', 'pid', 'sites', 'ssl', 'temp', 'www'].forEach(item =>
    (!fs.existsSync(join(target, 'nginx', item))) && fs.mkdirSync(join(target, 'nginx', item)))

  fs.writeFileSync(join(target, 'nginx/nginx.conf'), nginxTmpl(cfg.context), 'utf8')
  _exec(`mv ${homebrew}/nginx/nginx.conf ${homebrew}/nginx/nginx-original.conf`)
  _exec(`ln -sf $(pwd)/config/nginx/nginx.conf ${homebrew}/nginx/nginx.conf`)
  return true
}

const redis = (cfg, target, homebrew) => {
  (!fs.existsSync(join(target, 'redis'))) &&
    fs.mkdirSync(join(target, 'redis'))
  fs.writeFileSync(join(target, 'redis/redis.conf'), redisTmpl(cfg.context), 'utf8')
  _exec(`mv ${homebrew}/redis.conf ${homebrew}/redis-original.conf`)
  _exec(`ln -sf $(pwd)/config/redis.conf ${homebrew}/redis.conf`)
}

module.exports = config => function install (service, options) {
  const services = { dnsmasq, mongodb, nginx, redis }

  if (!fs.existsSync(join(__dirname, '..', 'config'))) {
    fs.mkdirSync(join(__dirname, '..', 'config'))
  }

  return services[service](config[service], join(__dirname, '..', 'config'), '/usr/local/etc')
}
