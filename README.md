# TVVLCKit-SPM

SPM wrapper for TVVLCKit binary distribution.

This repository contains the TVVLCKit framework for tvOS, sourced from [VLCKit](https://github.com/videolan/vlckit).

## How It Works

This repository does NOT store the framework binaries directly. Instead:

1. The framework is downloaded from VideoLAN's repository
2. It's repackaged using `xcodebuild -create-xcframework` with debug symbols
3. The repackaged framework is uploaded to GitHub Releases
4. `Package.swift` references the GitHub Release URL

## Automated Updates

A GitHub Actions workflow automatically:
- ✅ Checks daily for new TVVLCKit releases from VideoLAN
- ✅ Downloads and repackages the framework with debug symbols
- ✅ Creates a GitHub release with the repackaged framework
- ✅ Updates Package.swift with the new version and checksum
- ✅ Updates the LICENSE file
- ✅ Creates a pull request for review
- ✅ Sends notifications when updates are available

### Setup

The workflow is already configured, but ensure these settings are enabled:

**Manual trigger:**
   - Go to Actions → "Update TVVLCKit Framework"
   - Click "Run workflow" to manually check for updates

## Manual Update Process

If you need to manually update the framework:

1. Update `TAG_VERSION` and `TVOS_URL` in the script below
2. Run the script on macOS with Xcode installed
3. Create a GitHub release with the generated `TVVLCKit.xcframework.zip`
4. Commit the updated `Package.swift` and `LICENSE`

```bash
#!/bin/sh
set -e

rm -rf .tmp/ || true
mkdir -p .tmp/

TAG_VERSION="3.7.2"
TVOS_URL="https://download.videolan.org/cocoapods/prod/TVVLCKit-3.7.2-c73b779f-dd8bfdba.tar.xz"

echo "Downloading TVVLCKit..."
curl -L -o .tmp/TVVLCKit.tar.xz $TVOS_URL
tar -xf .tmp/TVVLCKit.tar.xz -C .tmp/

TVOS_LOCATION=".tmp/TVVLCKit-binary/TVVLCKit.xcframework"

echo "Creating TVVLCKit.xcframework..."
xcodebuild -create-xcframework \
    -framework "$TVOS_LOCATION/tvos-arm64_x86_64-simulator/TVVLCKit.framework" \
    -debug-symbols "${PWD}/$TVOS_LOCATION/tvos-arm64_x86_64-simulator/dSYMs/TVVLCKit.framework.dSYM" \
    -framework "$TVOS_LOCATION/tvos-arm64/TVVLCKit.framework" \
    -debug-symbols "${PWD}/$TVOS_LOCATION/tvos-arm64/dSYMs/TVVLCKit.framework.dSYM" \
    -output .tmp/TVVLCKit.xcframework

ditto -c -k --sequesterRsrc --keepParent ".tmp/TVVLCKit.xcframework" ".tmp/TVVLCKit.xcframework.zip"

PACKAGE_HASH=$(shasum -a 256 ".tmp/TVVLCKit.xcframework.zip" | awk '{ print $1 }')

echo "Checksum: $PACKAGE_HASH"
sed -i '' "s|download/v[0-9.]*|download/v$TAG_VERSION|g" Package.swift
sed -i '' "s|checksum: \"[^\"]*\"|checksum: \"$PACKAGE_HASH\"|g" Package.swift

cp -f .tmp/TVVLCKit-binary/COPYING.txt ./LICENSE

echo "Done! Upload .tmp/TVVLCKit.xcframework.zip to GitHub Release v$TAG_VERSION"
```

## Current Version

- **TVVLCKit:** v3.7.2
- **Source:** [VLCKit](https://github.com/videolan/vlckit)
- **Platform:** tvOS 13.0+

## License

This is a wrapper repository. The VLC framework is licensed under LGPL. See [LICENSE](LICENSE) file for details.
