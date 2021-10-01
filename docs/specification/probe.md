# Probe Instance

Probes are similar to agents, but are only allowed to egress data to a server.
They don't receive any kind of message, so their configuration is immutable.

## Probe Configuration

| Property                             | Description                                                      |
| ------------------------------------ | ---------------------------------------------------------------- |
| `s7s.probe.network.server_address`   | A CSV of IP addresses or domain names including port information |
| `s7s.probe.network.timeout`          | The server connection timeout in milliseconds                    |
| `s7s.probe.network.polling_interval` | The connection poll interval in milliseconds                     |

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
with AES using a key derived from a master key embedded in the configuration.
