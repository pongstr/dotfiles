'use strict'

fs    = require 'fs'
path  = require 'path'
cson  = require 'cson'
chlk  = require 'chalk'
conf  = cson.parseFile './config.cson'

require 'shelljs/global'

module.exports = (pkg) ->
  root = conf.dotfiles
  dirs = [
    "#{root}/config/dnsmasq"
    "#{root}/config/mongodb"
    "#{root}/config/mysql"
    "#{root}/config/nginx"
    "#{root}/config/redis"
  ]

  proc = (pkg, folders) ->
    conf = cson.parseFile(path.join __dirname, '../../config.cson')[pkg]
    pkgs =
      dnsmasq:  require './dnsmasq'
      mongodb:  require './mongodb'
      mysql:    require './mysql'
      nginx:    require './nginx'
      redis:    require './redis'
    content = pkgs[pkg] and pkgs[pkg](conf)

    if folders and folders.length > 0
      folders.forEach (dir) ->
        if fs.readdirSync(conf.config_dir).indexOf(dir) == -1
          mkdir '-p', "#{conf.config_dir}/#{dir}"
        return

    return new Promise((resolve, reject) ->
      fs.writeFile "#{root}/config/#{pkg}/#{pkg}.conf", content, 'utf8', (err) ->
        if err
          console.error(chlk.red "⚠️ #{err.message}")
          reject(err)
        else
          console.info(chlk.green "Successfully created #{pkg}.conf in #{root}/config/#{pkg}")
          resolve()
    )

  dirs.forEach (dir) ->
    if !test '-d', dir
      mkdir '-p', dir

  switch pkg
    when 'dnsmasq'
      proc(pkg)
      ln('-sf', "#{root}/config/dnsmasq/dnsmasq.conf", '/usr/local/etc/dnsmasq.conf')
    when 'redis'
      proc(pkg)
    when 'mysql'
      proc(pkg)
    when 'mongodb'
      proc(pkg, ['log', 'databases'])
    when 'nginx'
      proc(pkg, ['cache', 'logs', 'pid', 'sites', 'temp', 'www'])
      ln('-sf', "#{root}/config/nginx/nginx.conf", '/usr/local/etc/nginx/nginx.conf')
    when 'all'
      Promise.all([
        proc('dnsmasq')
        proc('mysql')
        proc('redis')
        proc('mongodb', ['log', 'databases'])
        proc('nginx', ['logs', 'pid', 'sites', 'www'])
      ]).then ((data) ->
        console.info(chlk.orange "\n  (づ｡◕‿‿◕｡)づ")
        console.info(chlk.blue "😇  Installed configs for these packages.")
        console.info ""
      ), (err) ->
        console.log ""
        console.error chlk.red "⚠️  (ノಠ益ಠ)ノ Woops! #{err} dafuq."
        console.log ""
    else
      console.log ""
      console.error chlk.red "⚠️  (ノಠ益ಠ)ノ Woops! #{pkg} doesn't seem to exist here."
      console.log ""
  return
