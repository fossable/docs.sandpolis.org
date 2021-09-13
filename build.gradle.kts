
plugins {
	id("com.diffplug.spotless") version "5.14.0"
}

spotless {
	format("markdown") {
		target("**/*.md")
		targetExclude("**/build/**")

		prettier().config(mapOf("proseWrap" to "always"))
	}

	format("yaml") {
		target("**/*.yml", "**/*.yaml")
		targetExclude("**/build/**")

		prettier()
	}
}
