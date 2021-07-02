.DEFAULT_GOAL := help

.PHONY: install
install: modules ## Installs this zsh config
	./scripts/generate-zshrc.sh > "$$HOME/.zshrc"

.PHONY: modules
modules:
	git submodule init
	git submodule update

.PHONY: zfunctions
zfunctions:
	mkdir -p "$$HOME/.zfunctions"

.PHONY: completions
completions: zfunctions ## Install other command completions
	stern --completion zsh > "$$HOME/.zfunctions/_stern"
	kyml completion zsh > "$$HOME/.zfunctions/_kyml"

.PHONY: help
help: ## Display this help. Thanks to https://suva.sh/posts/well-documented-makefiles/
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
