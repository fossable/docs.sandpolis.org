# Probe Instance

Probes are similar to agents, but are only allowed to egress data to a server.
They cannot receive messages, so their configuration is immutable unless the
system also runs an agent capable of managing probe instances.

Probe instances are designed to be extremely lightweight and run on almost any
hardware.

## Probe Configuration

```py
{
  "network" : {
    "server_address" : [
      String() # An IP address or DNS name with port info
    ],
    "connection": {
      "timeout" : Number(), # The connection timeout in milliseconds
      "interval" : Number() # The connection poll interval in milliseconds
    }
  },
  "collectors": {
    "/memory/total_used"
  }
}
```

## Connection Mode

The only connection mode supported by probes is the _polling_ mode. On a
configurable schedule, the probe reconnects to a server, flushes any cached
data, and closes the connection.

The probe may attempt a spontaneous connection outside of the regular schedule
at any time.

If a server is overloaded, the probe's connection attempt may not be accepted.
In this case, the probe may choose another server or wait and try again later.

## Connection Security

Unlike agents, probes do not use TLS. Rather, outgoing messages are encrypted
with AES256 using a sesion key derived from a master key embedded in the
configuration.

No two connections will use the same session key, so compromising it will only
yield an attacker decrypted data for the remainder of the connection.
