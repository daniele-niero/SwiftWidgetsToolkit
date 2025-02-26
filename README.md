# SwiftWidgetToolkit

[![Build Status - Windows](https://img.shields.io/appveyor/ci/{username}/SwiftWidgetToolkit?label=Windows)](https://ci.appveyor.com/project/{username}/SwiftWidgetToolkit)
[![Build Status - Linux](https://img.shields.io/travis/{username}/SwiftWidgetToolkit?label=Linux)](https://travis-ci.org/{username}/SwiftWidgetToolkit)
[![Build Status - macOS](https://img.shields.io/github/workflow/status/{username}/SwiftWidgetToolkit/CI?label=macOS)](https://github.com/{username}/SwiftWidgetToolkit/actions)

SwiftWidgetToolkit is a toolkit for creating widgets using Swift and SDL3.

## Overview

SwiftWidgetToolkit provides a set of tools and utilities for building graphical widgets in Swift. It leverages SDL3 for rendering and input handling.

## Installation

### Prerequisites

- Swift 6.0 or later
- SDL3 installed

### Steps

1. Clone the repository:
    ```sh
    git clone https://github.com/{username}/SwiftWidgetToolkit.git
    cd SwiftWidgetToolkit
    ```

2. Install SDL3 using vcpkg:
    ```sh
    vcpkg install sdl3
    ```

3. Build the project:
    ```sh
    swift build
    ```

## Usage

### Running the Example

To run the example application, use the following command:
```sh
swift run WidgetsExample

### License
This project is licensed under the MIT License. See the LICENSE file for details. 