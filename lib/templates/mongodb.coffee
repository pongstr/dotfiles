'use strict'

module.exports = (config) ->
  return "
systemLog:
\n  destination: file
\n  path: #{config.config_dir}/log/mongo.log
\n  logAppend: true
\nstorage:
\n  dbPath: #{config.config_dir}/databases
\nnet:
\n  bindIp: #{config.host}
\n  port: #{config.port}"
