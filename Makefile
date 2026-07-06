PROTOC_GEN_DART ?= $(HOME)/.pub-cache/bin/protoc-gen-dart
PROTO_OUT := lib/src/gen
PROTO_FILES := $(shell find proto -type f -name '*.proto' | sort)
WELL_KNOWN_PROTO_FILES := google/protobuf/descriptor.proto

# BSR module + pinned commit that proto/ is vendored from. The pin makes `make sync-protos`
# reproducible and taking newer upstream protos a deliberate, reviewable change; builds never
# touch BSR (proto/ + lib/src/gen are committed). To bump: `make proto-latest` for the newest
# commit, set PROTO_COMMIT below, then `make sync-protos && make protos` and review the diff.
PROTO_MODULE := buf.build/pugsh/pug
PROTO_COMMIT := 739d784162d649a3be748db76d3fafd8

.PHONY: protos sync-protos typed-track check-codegen verify-version format analyze test check ci proto-latest

sync-protos:
	@command -v buf >/dev/null || (echo "buf CLI is required; install: brew install bufbuild/buf/buf" && exit 1)
	# Pull (export) ONLY the SDK-relevant packages from the BSR module. `buf
	# export` is a read-only download (BSR -> proto/), never a push. `--path` is
	# an allowlist and buf adds the transitive imports (buf/validate, google
	# well-known types) automatically, so backend-only packages (shared/**,
	# dashboard/**, public/**, workers/**) and the unused common/v1 filter/time
	# protos are never re-synced. Add a `--path` here when the SDK starts using a
	# new package.
	buf export $(PROTO_MODULE):$(PROTO_COMMIT) --output proto/ \
		--path sdk \
		--path common/events/v1 \
		--path common/v1/property_value.proto
	@echo "Synced SDK protos into proto/ at $(PROTO_COMMIT). Run 'make protos' to regenerate Dart code."

# Print the newest commit on the module's main branch, to update PROTO_COMMIT above.
proto-latest:
	@buf registry module commit resolve $(PROTO_MODULE):main

protos:
	@command -v protoc >/dev/null || (echo "protoc is required" && exit 1)
	@test -x "$(PROTOC_GEN_DART)" || (echo "protoc-gen-dart not found at $(PROTOC_GEN_DART). Run: dart pub global activate protoc_plugin" && exit 1)
	mkdir -p $(PROTO_OUT)
	PATH="$$(dirname "$(PROTOC_GEN_DART)"):$$PATH" protoc --proto_path=proto --dart_out=$(PROTO_OUT) $(WELL_KNOWN_PROTO_FILES) $(PROTO_FILES)
	find $(PROTO_OUT) \( -name '*.pbjson.dart' -o -name '*.pbserver.dart' \) -delete
# Prune stray per-message pbenum files, but keep the ones a committed .pb.dart
# still imports. Dropping common/events/v1/options.pbenum.dart (the Platform
# enum, imported by options.pb.dart) leaves a dangling import that fails analysis.
	find $(PROTO_OUT) -name '*.pbenum.dart' ! -path '$(PROTO_OUT)/buf/validate/validate.pbenum.dart' ! -path '$(PROTO_OUT)/google/protobuf/descriptor.pbenum.dart' ! -path '$(PROTO_OUT)/common/events/v1/options.pbenum.dart' -delete
	rm -f $(PROTO_OUT)/google/protobuf/descriptor.pb.dart
	$(MAKE) typed-track

typed-track:
	dart run tool/generate_track_namespace.dart
	dart format lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/well_known_event_schemas.dart

check-codegen:
	$(MAKE) typed-track
	@if ! git diff --exit-code -- lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/well_known_event_schemas.dart > /dev/null; then \
		echo "Codegen drift detected. Run 'make typed-track' and commit the result."; \
		git diff -- lib/src/track_namespace.dart lib/src/well_known_events.dart lib/src/well_known_event_schemas.dart; \
		exit 1; \
	fi

# Guards against pubspec.yaml `version:` and pugSdkVersion in
# lib/src/version.dart drifting apart, which would ship a stale sdkVersion
# auto-property. Bump both together on every release.
verify-version:
	@pubspec_ver=$$(awk '/^version:/{print $$2; exit}' pubspec.yaml); \
	dart_ver=$$(grep -E 'const String pugSdkVersion' lib/src/version.dart | sed -E "s/.*'([^']*)'.*/\1/"); \
	if [ "$$pubspec_ver" != "$$dart_ver" ]; then \
		echo "Version mismatch: pubspec.yaml=$$pubspec_ver lib/src/version.dart=$$dart_ver"; \
		echo "Update pugSdkVersion in lib/src/version.dart to match pubspec.yaml, then re-run."; \
		exit 1; \
	fi

format:
	dart format lib test

analyze:
	flutter analyze

test:
	flutter test

# `check` is the routine local-dev target. It does NOT regenerate protobufs
# or codegen — instead, `check-codegen` re-runs the typed-track generator and
# diffs against the committed files, so it catches the case where the proto
# sources were updated but `make typed-track` was not re-run. Run `make
# protos` manually before commit when proto sources change.
check: verify-version check-codegen format analyze test

# `ci` is the strict CI target: regenerates protobufs from scratch and then
# runs every other check. Requires `protoc` + `protoc-gen-dart` on PATH.
ci: protos verify-version check-codegen format analyze test
