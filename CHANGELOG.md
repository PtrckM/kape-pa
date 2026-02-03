# Changelog

All notable changes to Kape pa will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-16

### Added
- Initial release of Kape pa
- Menu bar app with coffee cup icon
- Sleep prevention functionality using macOS power management APIs
- Time interval options: 5 minutes, 10 minutes, 15 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 24 hours
- Countdown timer display in menu bar
- Stop button to cancel active timers
- Power button to quit the application
- Title "Kape pa V1.0" and subtitle "created by: PtrckM" in menu
- Tooltips for buttons
- App configured to run only in menu bar (no dock icon)
- GNU GPL v3 license

### Technical Details
- Built with Swift 5.3 and SwiftUI
- Uses IOKit power management for sleep prevention
- Minimum macOS version: 11.0
- Project structure optimized for Xcode
