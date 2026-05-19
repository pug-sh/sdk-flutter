PROTOC_GEN_DART ?= $(HOME)/.pub-cache/bin/protoc-gen-dart
PROTO_OUT := lib/src/gen
PROTO_FILES := $(shell find proto -type f -name '*.proto' | sort)
WELL_KNOWN_PROTO_FILES := google/protobuf/descriptor.proto

.PHONY: protos sync-protos typed-track check-codegen format analyze test check

sync-protos:
	@command -v buf >/dev/null || (echo "buf CLI is required; install: brew install bufbuild/buf/buf" && exit 1)
	buf export buf.build/fivebits/pug --output proto/
	@echo "Synced buf catalog into proto/. Run 'make protos' to regenerate Dart code."

protos:
	@command -v protoc >/dev/null || (echo "protoc is required" && exit 1)
	@test -x "$(PROTOC_GEN_DART)" || (echo "protoc-gen-dart not found at $(PROTOC_GEN_DART). Run: dart pub global activate protoc_plugin" && exit 1)
	mkdir -p $(PROTO_OUT)
	PATH="$$(dirname "$(PROTOC_GEN_DART)"):$$PATH" protoc --proto_path=proto --dart_out=$(PROTO_OUT) $(WELL_KNOWN_PROTO_FILES) $(PROTO_FILES)
	find $(PROTO_OUT) \( -name '*.pbjson.dart' -o -name '*.pbserver.dart' \) -delete
	find $(PROTO_OUT) -name '*.pbenum.dart' ! -path '$(PROTO_OUT)/buf/validate/validate.pbenum.dart' ! -path '$(PROTO_OUT)/google/protobuf/descriptor.pbenum.dart' -delete
	rm -f $(PROTO_OUT)/google/protobuf/descriptor.pb.dart
	$(MAKE) typed-track

typed-track:
	dart run tool/generate_track_namespace.dart
	dart format lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/events.dart

check-codegen:
	$(MAKE) typed-track
	@if ! git diff --exit-code -- lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/events.dart > /dev/null; then \
		echo "Codegen drift detected. Run 'make typed-track' and commit the result."; \
		git diff -- lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/events.dart; \
		exit 1; \
	fi

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

check: protos check-codegen format analyze test
