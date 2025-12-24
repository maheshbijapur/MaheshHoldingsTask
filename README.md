# MaheshHoldingsTask

iOS assignment demonstrating a Holdings / Portfolio screen built using UIKit and MVVM.

## Features
- Fetches holdings data from remote API
- Displays holdings in a list using UITableView
- Portfolio summary with expandable / collapsible bottom view
- Correct financial calculations:
  - Current Value
  - Total Investment
  - Today's P&L
  - Total P&L (with percentage)
- Green / Red P&L indicators
- Unit tests for ViewModel calculations

## Architecture
- MVVM
- Programmatic UIKit (no storyboards)
- Clean separation of Model, ViewModel, and View

## Tech Stack
- Swift
- UIKit
- URLSession
- XCTest

## How to Run
1. Open `MaheshHoldingsTask.xcodeproj`
2. Select an iPhone simulator
3. Run the app (⌘R)

## Tests
- Run tests using ⌘U
- ViewModel unit tests validate portfolio calculations using mock data

## Notes
- Tab bar UI is intentionally omitted as per assignment instructions
- UI is implemented to match reference behavior, not pixel-perfect design

