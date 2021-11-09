#!/bin/bash
## Generate specification as PDF.

set -o pipefail

# Add section numbers to markdown headings
add_section_numbers() {
	section=$1
	i=1
	while read -r line; do
		if j=$(echo "${line}" | awk '{print $1}' | grep -E '^#+$' | wc -c); then

			if [ $j -eq $i ]; then
				section="${section%.*}.$((${section##*.} + 1))"
			fi

			while [ $j -gt $i ]; do
				i=$((i + 1))
				section="${section}.1"
			done

			while [ $j -lt $i ]; do
				i=$((i - 1))
				section=${section%.*}
				section="${section%.*}.$((${section##*.} + 1))"
			done

			# Output line
			echo "$(echo "${line}" | awk '{print $1}') ${section} $(echo "${line}" | sed 's/^#* //')"
		else
			# Output line
			echo "${line}"
		fi
	done
}

# Merge markdown files
(

	cat <<-EOF
		## 1 Modules
	EOF

	cat docs/specification/com.sandpolis.core.agent.md \
		| add_section_numbers '1.1'
	cat docs/specification/com.sandpolis.core.client.md \
		| add_section_numbers '1.2'
	cat docs/specification/com.sandpolis.core.deployer.md \
		| add_section_numbers '1.3'
	cat docs/specification/com.sandpolis.core.probe.md \
		| add_section_numbers '1.4'
	cat docs/specification/com.sandpolis.core.server.md \
		| add_section_numbers '1.5'
	(
		cat docs/specification/com.sandpolis.core.instance.md
		cat docs/specification/messages/com.sandpolis.core.instance.md
	) | add_section_numbers '1.6'
	(
		cat docs/specification/com.sandpolis.core.net.md
		cat docs/specification/messages/com.sandpolis.core.net.md
	) | add_section_numbers '1.7'
	(
		cat docs/specification/com.sandpolis.core.clientserver.md
		cat docs/specification/messages/com.sandpolis.core.clientserver.md
	) | add_section_numbers '1.8'
	(
		cat docs/specification/com.sandpolis.core.serveragent.md
		cat docs/specification/messages/com.sandpolis.core.serveragent.md
	) | add_section_numbers '1.9'

	cat <<-EOF
		## 2 Standard Instances
	EOF

	cat docs/specification/com.sandpolis.server.vanilla.md \
		| add_section_numbers '2.1'
	cat docs/specification/com.sandpolis.agent.kilo.md \
		| add_section_numbers '2.2'
	cat docs/specification/com.sandpolis.agent.micro.md \
		| add_section_numbers '2.3'
	cat docs/specification/com.sandpolis.agent.boot.md \
		| add_section_numbers '2.4'
	cat docs/specification/com.sandpolis.client.lifegem.md \
		| add_section_numbers '2.5'
	cat docs/specification/com.sandpolis.client.brightstone.md \
		| add_section_numbers '2.6'

	cat <<-EOF
		## 3 Standard Plugins
	EOF

	cat docs/specification/com.sandpolis.plugin.alert.md \
		| add_section_numbers '3.1'
	(
		cat docs/specification/com.sandpolis.plugin.desktop.md
		cat docs/specification/messages/com.sandpolis.plugin.desktop.md
	) | add_section_numbers '3.2'
	(
		cat docs/specification/com.sandpolis.plugin.device.md
		cat docs/specification/messages/com.sandpolis.plugin.device.md
	) | add_section_numbers '3.3'
	(
		cat docs/specification/com.sandpolis.plugin.filesystem.md
		cat docs/specification/messages/com.sandpolis.plugin.filesystem.md
	) | add_section_numbers '3.4'
	(
		cat docs/specification/com.sandpolis.plugin.shell.md
		cat docs/specification/messages/com.sandpolis.plugin.shell.md
	) | add_section_numbers '3.5'
	(
		cat docs/specification/com.sandpolis.plugin.snapshot.md
		cat docs/specification/messages/com.sandpolis.plugin.snapshot.md
	) | add_section_numbers '3.6'
	(
		cat docs/specification/com.sandpolis.plugin.update.md
		cat docs/specification/messages/com.sandpolis.plugin.update.md
	) | add_section_numbers '3.7'

) >/tmp/specification.md

# Generate PDF
md-to-pdf /tmp/specification.md
mv /tmp/specification.pdf pdf/specification.pdf
