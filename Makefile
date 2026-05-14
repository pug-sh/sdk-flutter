PROTOC_GEN_DART ?= $(HOME)/.pub-cache/bin/protoc-gen-dart
PROTO_OUT := lib/src/gen
PROTO_FILES := $(shell find proto -type f -name '*.proto' | sort)
WELL_KNOWN_PROTO_FILES := google/protobuf/descriptor.proto

.PHONY: protos format analyze test check

protos:
	@command -v protoc >/dev/null || (echo "protoc is required" && exit 1)
	@test -x "$(PROTOC_GEN_DART)" || (echo "protoc-gen-dart not found at $(PROTOC_GEN_DART). Run: dart pub global activate protoc_plugin" && exit 1)
	mkdir -p $(PROTO_OUT)
	PATH="$$(dirname "$(PROTOC_GEN_DART)"):$$PATH" protoc --proto_path=proto --dart_out=$(PROTO_OUT) $(WELL_KNOWN_PROTO_FILES) $(PROTO_FILES)
	find $(PROTO_OUT) \( -name '*.pbjson.dart' -o -name '*.pbserver.dart' \) -delete
	find $(PROTO_OUT) -name '*.pbenum.dart' ! -path '$(PROTO_OUT)/buf/validate/validate.pbenum.dart' ! -path '$(PROTO_OUT)/google/protobuf/descriptor.pbenum.dart' -delete
	rm -f $(PROTO_OUT)/google/protobuf/descriptor.pb.dart

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

check: protos format analyze test
