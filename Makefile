.DEFAULT_GOAL := help

#------------------------------------
# Help
#------------------------------------
TARGET_MAX_CHAR_NUM := 25

# COLORS
RED     := \033[0;31m
GREEN   := \033[0;32m
YELLOW  := \033[0;33m
BLUE    := \033[0;34m
MAGENTA := \033[0;35m
CYAN    := \033[0;36m
WHITE   := \033[0;37m
RESET   := \033[0;10m

.PHONY: help
## Show help | Help
help:
	@echo ''
	@echo 'Usage:'
	@printf "  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}"
	@echo ''
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
		    if (index(lastLine, "|") != 0) { \
				stage = substr(lastLine, index(lastLine, "|") + 1); \
				printf "\n ${GRAY}%s: \n", stage;  \
			} \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			if (index(lastLine, "|") != 0) { \
				helpMessage = substr(helpMessage, 0, index(helpMessage, "|")-1); \
			} \
			printf "    ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
#------------------------------------


#------------------------------------
# Docker commands
#------------------------------------

.PHONY: docker-build
## Run docker-build | Docker
docker-build:
	docker build -t homepage .

.PHONY: docker-run
## Run docker-run
docker-run:
	docker run -p 8000:80 homepage

.PHONY: docker-sh
## Run docker shell
docker-sh:
	docker run -ti homepage sh
#------------------------------------
