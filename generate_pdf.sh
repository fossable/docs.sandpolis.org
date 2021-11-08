#!/bin/bash
## Generate specification as PDF.

# Merge markdown files
(
	cat docs/specification/com.sandpolis.core.agent.md
	cat docs/specification/com.sandpolis.core.clientserver.md
	cat docs/specification/com.sandpolis.core.deployer.md
	cat docs/specification/com.sandpolis.core.instance.md
	cat docs/specification/com.sandpolis.core.net.md
	cat docs/specification/messages/com.sandpolis.core.net.md
	cat docs/specification/com.sandpolis.core.probe.md
	cat docs/specification/com.sandpolis.core.server.md
	cat docs/specification/com.sandpolis.core.serveragent.md

	cat docs/specification/com.sandpolis.agent.boot.md
	cat docs/specification/com.sandpolis.agent.kilo.md
	cat docs/specification/com.sandpolis.agent.micro.md
	cat docs/specification/com.sandpolis.client.brightstone.md
	cat docs/specification/com.sandpolis.client.lifegem.md
	cat docs/specification/com.sandpolis.server.vanilla.md

	cat docs/specification/com.sandpolis.plugin.agent.md
	cat docs/specification/com.sandpolis.plugin.desktop.md
	cat docs/specification/com.sandpolis.plugin.device.md
	cat docs/specification/com.sandpolis.plugin.filesystem.md
	cat docs/specification/com.sandpolis.plugin.shell.md
	cat docs/specification/com.sandpolis.plugin.snapshot.md
	cat docs/specification/com.sandpolis.plugin.update.md

) >/tmp/specification.md

# Generate PDF
markdown-pdf --out pdf/specification.pdf /tmp/specification.md
