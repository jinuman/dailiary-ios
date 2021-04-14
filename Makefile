app:
	make tuist
	make cocoapods

cocoapods:
	@echo "Pod install"
	@bundle exec pod binary prebuild || bundle exec pod binary prebuild --repo-update

tuist:
	@echo "Generate project"
	@tuist generate || tuist generate --project-only