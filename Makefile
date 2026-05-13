PROTOC_GEN_DART ?= $(HOME)/.pub-cache/bin/protoc-gen-dart
PROTO_OUT := lib/src/gen
PROTO_FILES := $(shell find proto -type f -name '*.proto' | sort)

.PHONY: protos format analyze test check

protos:
	@command -v protoc >/dev/null || (echo "protoc is required" && exit 1)
	@test -x "$(PROTOC_GEN_DART)" || (echo "protoc-gen-dart not found at $(PROTOC_GEN_DART). Run: dart pub global activate protoc_plugin" && exit 1)
	mkdir -p $(PROTO_OUT)
	PATH="$$(dirname "$(PROTOC_GEN_DART)"):$$PATH" protoc --proto_path=proto --dart_out=$(PROTO_OUT) $(PROTO_FILES)
	find $(PROTO_OUT) \( -name '*.pbenum.dart' -o -name '*.pbjson.dart' -o -name '*.pbserver.dart' \) -delete

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

check: protos format analyze test
