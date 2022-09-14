publish-gem:
	gem build aaf-secure_headers.gemspec
	gem push aaf-secure_headers-*.gem
	rm aaf-secure_headers-*.gem