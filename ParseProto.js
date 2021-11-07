#!/usr/bin/node
// Simple script to parse a .proto file and output a markdown file containing
// message definitions.

var proto = require("proto-parser");
var fs = require("fs");

fs.readFile(process.argv[2], "utf8", function (err, data) {
	if (err) throw err;

	var root = proto.parse(data);
	var package = root["package"];
	root = root["root"];

	package.split(".").forEach((element) => {
		root = root["nested"][element];
	});

	for (const [key, value] of Object.entries(root["nested"])) {
		if (
			key.startsWith("RQ_") ||
			key.startsWith("RS_") ||
			key.startsWith("EV_")
		) {
			console.log(`\n### ${key}`);
			console.log(`${value["comment"]}\n`);

			if (value["syntaxType"] === "MessageDefinition") {
				console.log("| Field | Type | Description |");
				console.log("|-------|------|-------------|");

				for (const [field, field_value] of Object.entries(
					value["fields"]
				)) {
					console.log(
						`| ${field} | ${field_value["type"]["value"]} | ${field_value["comment"]} |`
					);
				}
			} else if (value["syntaxType"] === "EnumDefinition") {
				console.log("| Field | Description |");
				console.log("|-------|-------------|");

				for (const [enum_name, enum_tag] of Object.entries(
					value["values"]
				)) {
					console.log(`| ${enum_name} | ${enum_tag} |`);
				}
			}
		}
	}
});
