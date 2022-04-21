GO ?= go
GOBIN ?= $$($(GO) env GOPATH)/bin
GOLANGCI_LINT ?= $(GOBIN)/golangci-lint
GOLANGCI_LINT_VERSION ?= v1.43.0
GOGOPROTOBUF ?= protoc-gen-gogofaster
GOGOPROTOBUF_VERSION ?= v1.3.1

GO_MIN_VERSION ?= "1.17"
GO_BUILD_VERSION ?= "1.17.2"
GO_MOD_ENABLED_VERSION ?= "1.12"
GO_MOD_VERSION ?= "$(shell go mod edit -print | awk '/^go[ \t]+[0-9]+\.[0-9]+(\.[0-9]+)?[ \t]*$$/{print $$2}')"
GO_SYSTEM_VERSION ?= "$(shell go version | awk '{ gsub(/go/, "", $$3); print $$3 }')"

COMMIT_HASH ?= "$(shell git describe --long --dirty --always --match "" || true)"
CLEAN_COMMIT ?= "$(shell git describe --long --always --match "" || true)"
COMMIT_TIME ?= "$(shell git show -s --format=%ct $(CLEAN_COMMIT) || true)"
LDFLAGS = -s -w

.PHONY: all
all: build lint vet test-race binary

.PHONY: linux
linux: export GOOS=linux
linux: export GOARCH=amd64
linux: binary

.PHONY: binary
binary: export CGO_ENABLED=0
binary: dist
	$(GO) version
	$(GO) build -trimpath -ldflags "$(LDFLAGS)" -o dist/demo ./app

dist:
	mkdir $@

.PHONY: clean
clean:
	$(GO) clean
	rm -rf dist/*