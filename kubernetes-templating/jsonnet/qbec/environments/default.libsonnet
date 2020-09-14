
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
  currency +: {
    Port: 7000,
    Namespace: 'hipster-shop',
  },
  }
}
