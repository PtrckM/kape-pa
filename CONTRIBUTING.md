# Contributing to Kape pa

Thank you for your interest in contributing to Kape pa! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Bugs

- Use the GitHub issue tracker to report bugs
- Provide detailed information about the bug
- Include steps to reproduce the issue
- Mention your macOS version and Xcode version

### Suggesting Features

- Open an issue with the "enhancement" label
- Describe the feature you would like to see
- Explain why this feature would be useful

### Pull Requests

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add some amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## Code Style

- Follow Swift coding conventions
- Use meaningful variable and function names
- Add comments where necessary
- Keep the code clean and readable

## Project Structure

```
kape-pa/
├── kape pa/
│   ├── kape pa/
│   │   ├── kape_paApp.swift      # Main app logic
│   │   ├── ContentView.swift     # SwiftUI view (minimal)
│   │   ├── Info.plist           # App configuration
│   │   └── Assets.xcassets      # App icons and images
│   └── kape pa.xcodeproj        # Xcode project file
├── README.md                     # Project documentation
├── LICENSE                       # GPL v3 license
└── .gitignore                    # Git ignore file
```

## Development Setup

1. Clone your forked repository
2. Open the Xcode project
3. Build and run the project
4. Make your changes
5. Test thoroughly

## Testing

- Test on different macOS versions if possible
- Ensure the app works correctly in the menu bar
- Verify timer functionality
- Check that the app properly releases sleep assertions

## License

By contributing, you agree that your contributions will be licensed under the GNU General Public License v3.0.
