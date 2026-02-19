# TVShows

<p align="center">
    <img src="https://img.shields.io/badge/Swift-5.9.1-orange.svg" />
    <img src="https://img.shields.io/badge/Xcode-15.2.X-orange.svg" />
    <img src="https://img.shields.io/badge/platforms-iOS-brightgreen.svg?style=flat" alt="iOS" />
    <a href="https://www.linkedin.com/in/rodrigo-silva-6a53ba300/" target="_blank">
        <img src="https://img.shields.io/badge/LinkedIn-@RodrigoSilva-blue.svg?style=flat" alt="LinkedIn: @RodrigoSilva" />
    </a>
</p>

Study iOS app: UI recreated with differences based on a SwiftUI class reference. 100% original logic implemented from scratch using UIKit, ViewCode and MVVM.


| Demo | Idle | In use |
| --- | --- | --- |
| ![Demo](https://github.com/user-attachments/assets/5217b018-d055-4a09-b03f-6bf3e2d5742a) | ![Idle](https://github.com/user-attachments/assets/aa4b207c-e8fd-4fcc-951e-b1949814e542) | ![In use](https://github.com/user-attachments/assets/83cb6dc1-00b8-4df9-87a8-9c8d8ff01145) |


## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Functionalities](#functionalities)
- [Setup](#setup)

## Features

- View Code (UIKit)
- Custom elements
- Dark Mode

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
- Swift 5.0 or later

## Functionalities

- [x] **Bill Input**: User can enter the total bill amount.
- [x] **Predefined Tip Options**: Quick selection buttons for 10%, 15%, and 20%.
- [x] **Custom Tip**: Option to enter a custom tip percentage.
- [x] **Split Between People**: Increase or decrease the number of people using stepper-style buttons.
- [x] **Total With Tip**: Displays total bill including tip.
- [x] **Tip Amount Display**: Shows the calculated tip value separately.
- [x] **Per Person Calculation**: Automatically calculates and displays the amount each person should pay.
- [x] **Real-Time Updates**: Values update instantly when changing tip percentage or number of people.
- [x] **UIKit Interface**: Entire interface built with UIKit and ViewCode (no Storyboards).


## Setup

First of all download and install Xcode, Swift Package Manager and then clone the repository:

```sh
$ git@github.com:diggosilva/TipCalculator-iOS.git
```

After cloning, do the following:

```sh
$ cd <diretorio-base>/TipCalculator-iOS/
$ open TipCalculator-iOS.xcodeproj/
```
