#!/bin/bash
## Generate markdown files from the message implementations.

# Assume the sandpolis repo is a sibling to the docs repo
if [ -d ../../sandpolis ]; then
	echo "No sandpolis repository found" 1>&2
	exit 1
fi

for proto in $(find ../../sandpolis -name "messages.proto"); do

	# Determine module name
	module=$(dirname ${proto} | sed 's/.proto$//' | tr '/' '.' | sed 's/^.*src.main.proto.//')
	./ParseProto.js ${proto} >../docs/specification/messages/${module}.md
done
exit 0
