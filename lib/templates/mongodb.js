'use strict'

module.exports = (ctx) => {
  return `systemLog:
  destination: file
  path: ${ctx.logs}
  logAppend: true
storage:
  dbPath: ${ctx.database_path}
net:
  bindIp: ${ctx.host}
  port: ${ctx.port}\n`
}
