# Networking Module

## Sandpolis Protocol

Sandpolis uses a custom binary protocol based on
[protocol buffers](https://developers.google.com/protocol-buffers) for all
inter-instance network communications. By default, the server listens on TCP
port **8768**.

Most communication happens over TCP connections among instances and the server,
but the server can also coordinate direct TCP or UDP "sessions" between any two
instances that need to transfer high-volume or low-latency data.

## Streams

Many operations require real-time data for a short-lived or long-lived session.

All streams have a _source_ and a _sink_ and can exist between any two instances
(a stream where the source and sink reside on the same instance is called a
_local stream_). The source's purpose is to produce _stream events_ at whatever
frequency is appropriate for the use-case and the sink's purpose is to consume
those stream events.

### Multicasting

Stream sources can push events to more than one sink simultaneously. This is
called multicasting and can save bandwidth in situations where multiple users
request the same resource at the same time.

## Session

Clients and agents maintain an ephemeral session which consists of a session
identifier and authentication state.

Session identifiers are 4-byte unsigned integers that have the instance type and
instance flavor encoded in them.

```
 0         1         2           3
 012345678901234567890123 45678 901
[        Base CVID       | FID |IID]
```
