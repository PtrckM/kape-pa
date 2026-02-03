# Kape pa - macOS Menu Bar App

A simple macOS menu bar application that prevents your system from sleeping for a user-specified duration.

## Features

- Keep your Mac awake for predefined time intervals
- Simple menu bar interface with coffee cup icon
- Time options: 5 minutes, 10 minutes, 15 minutes, 30 minutes, 1 hour, 6 hours, 12 hours, 24 hours
- Stop button to cancel active timers
- Clean, minimal UI design

## Requirements

- macOS 11.0 or later
- Xcode 12.0 or later
- Swift 5.3 or later

## Installation

### From Source

1. Clone this repository:
   ```bash
   git clone https://github.com/PtrckM/kape-pa.git
   cd kape-pa
   ```

2. Open the project in Xcode:
   ```bash
   open "kape pa/kape pa.xcodeproj"
   ```

3. Build and run the project:
   - Select "My Mac" as the destination
   - Press `Cmd + R` to build and run
   - Or go to `Product > Run`

4. The app will appear in your menu bar as a coffee cup icon

### Building for Distribution

1. Open the project in Xcode
2. Select "Any Mac" as the destination
3. Go to `Product > Archive`
4. In the Organizer window, select the archive and click "Distribute App"
5. Choose "Copy App" and follow the prompts

## Usage

1. Click the coffee cup icon in your menu bar
2. Select a time duration from the dropdown menu
3. The app will prevent your Mac from sleeping for the selected duration
4. The menu bar icon will show a countdown timer
5. Click the stop button (square icon) to cancel the timer early
6. Click the power button to quit the app

## How It Works

The app uses macOS power management APIs (`IOPMAssertionCreateWithName`) to prevent system sleep and display sleep. When you set a timer, it creates a power assertion that keeps your Mac awake. The assertion is automatically released when the timer expires or when you manually stop it.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Author

Created by PtrckM

## Changelog

### v1.0
- Initial release
- Menu bar app with sleep prevention
- Multiple time interval options
- Stop timer functionality
- Coffee cup icon
