'use strict'

module.exports = (ctx) => {
  return `systemLog:
  destination: file
  path: ${ctx.logs}
  logAppend: true
storage:
  dbPath: ${ctx.dbPath}
net:
  bindIp: ${ctx.host}
  port: ${ctx.port}\n`
}
