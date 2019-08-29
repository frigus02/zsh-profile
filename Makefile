.DEFAULT_GOAL:=help

.PHONY: install
install: pure zsh-nvm ## Installs this zsh config
	ln -sF "$$PWD/zshrc" "$$HOME/.zshrc"

.PHONY: zfunctions
zfunctions:
	mkdir -p "$$HOME/.zfunctions"

.PHONY: pure
pure: zfunctions ## Installs the pure prompt
	./add-kube-ps1-to-pure.sh "$$PWD/pure/pure.zsh" > "$$HOME/.zfunctions/prompt_pure_setup"
	cp "$$PWD/pure/async.zsh" "$$HOME/.zfunctions/async"

.PHONY: zsh-nvm
zsh-nvm: zfunctions ## Installs the pure zsh-nvm
	cp "$$PWD/zsh-nvm/zsh-nvm.plugin.zsh" "$$HOME/.zfunctions/zsh-nvm"

.PHONY: completions
completions: zfunctions ## Install other command completions
	stern --completion zsh > "$$HOME/.zfunctions/_stern"
	kyml completion zsh > "$$HOME/.zfunctions/_kyml"

.PHONY: help
help: ## Display this help. Thanks to https://suva.sh/posts/well-documented-makefiles/
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
