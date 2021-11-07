#!/bin/bash
## Generate markdown files from the message implementations.

# Assume the sandpolis repo is a sibling to the docs repo
for proto in $(find ../sandpolis -name "messages.proto"); do

	# Determine module name
	module=$(dirname ${proto} | sed 's/.proto$//' | tr '/' '.' | sed 's/^.*src.main.proto.//')
	./ParseProto.js ${proto} >docs/specification/msg/${module}.md
done
