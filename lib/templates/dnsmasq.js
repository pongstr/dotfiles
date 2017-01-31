'use strict'

module.exports = (ctx) => {
  return `
bind-interfaces
keep-in-foreground
no-resolv

address=/${ctx.ext}/${ctx.host}
listen-address=${ctx.host}\n`
}
