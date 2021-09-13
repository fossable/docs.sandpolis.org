# Sandpolis Official Documentation

This site explains how to **install**, **configure**, and **maintain**
Sandpolis. It also contains the official specification and a high-level
programming reference useful to developers.

## The Basics

You are likely already familiar with other remote-control applications that
allow you to monitor/manage many different computers from a single pane of
glass. To use these tools, you might install an _agent_ on the computers you
wish to manage and direct them to connect back to the main application running
on your workstation.

While relatively simple, there are some evident disadvantages to this approach:

- Your computer may not have a stable IP address or be reachable over the
  Internet
- You may want to quickly perform rudimentary tasks away from your computer such
  as from a mobile device
- This architecture does not scale as the number of agents increases

Most modern administration systems now use a client-server-agent (CSA)
architecture to address these problems. Rather than connecting agents directly
to an application on your computer, a central server mediates interactions
between you and your systems.

### Client <==> Server <==> Agent

With CSA, clients and agents can come and go without affecting the rest of the
network. This means that:

- background or scheduled tasks can continue after a user logs out;
- users are not restricted to a particular user interface;
- users don't have to adjust their firewalls or port-forwarding rules.

CSA also comes with a few drawbacks:

###### The server is another application to maintain

Although easy to deploy, the Sandpolis server still requires some effort to
maintain. In addition to the initial setup, it's important to periodically
update the server and harden its security.

###### The server is a high value attack target

The server is designed to be as resilient and secure as possible, but it can't
be perfect. If an attacker is able to compromise the server (or a user account
with sufficiently high privileges), they effectively have full control over all
systems connected to it.

To help mitigate the risks, all Sandpolis user accounts are **required** to use
two-factor authentication and password rotation.

Access alerts can also be configured to help unauthorized accesses get noticed
as early as possible.

###### The server can increase network latency

Usually the network route between a user and their systems will be faster than
the route through the server. This is especially true if a user is on the same
lan as their systems. To improve latency and throughput, the server can
automatically coordinate a direct connection between any two nodes for
high-volume or time-sensitive messages like remote desktop, file transfers, etc.

### Real-time monitoring

Sandpolis offers "real-time" monitoring and management when you need it, and
efficient scalability when you're not looking.

### Extensibility via plugins
