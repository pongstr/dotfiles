'use strict'

module.exports = (config) ->
  return "
bind-interfaces
\nkeep-in-foreground
\nno-resolv
\n\naddress=/#{config.ext}/#{config.host}
\nlisten-address=#{config.host}\n"
