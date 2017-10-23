
module.exports = (arg, opts) => {
  console.log('action', arg)

  opts.provider && console.log('option: provider', opts.provider)
}
