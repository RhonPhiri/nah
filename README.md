# nah
## Description
New Apostolic Church Hymnal is a lightweight, offline hymnal app created with flutter (Beginner level). It includes hymns in various languages including English, with a focus on simplicity, accessibility, and ease of use.

The app offers:

    - A collection of traditional and local-language hymns

    - Full-screen reading for distraction-free use

    - Dark mode for comfortable night-time reading

    - Search and bookmark functionality for quick access

It is intended as a helpful companion when a physical hymnal isn’t available—not as a replacement. All bookmarks and preferences are stored locally on user's device.
--

## Project Structure
This project tries to follow the feature first app architecture as described under [Flutter Architectural Case Study](https://docs.flutter.dev/app-architecture/case-study)

Here is the overview
```
    lib
├─┬─ ui
│ ├─┬─ core
│ │ ├─┬─ ui
│ │ │ └─── <shared widgets>
│ │ └─── themes
│ └─┬─ <FEATURE NAME>
│   ├─┬─ view_model
│   │ └─── <view_model class>.dart
│   └─┬─ widgets
│     ├── <feature name>_screen.dart
│     └── <other widgets>
├─┬─ domain
│ └─┬─ models
│   └─── <model name>.dart
├─┬─ data
│ ├─┬─ repositories
│ │ └─── <repository class>.dart
│ ├─┬─ services
│ │ └─── <service class>.dart
│ └─┬─ model
│   └─── <api model class>.dart
├─── config
├─── utils
├─── routing
├─── main_staging.dart
├─── main_development.dart
└─── main.dart

// The test folder contains unit and widget tests
test
├─── data
├─── domain
├─── ui
└─── utils

// The testing folder contains mocks other classes need to execute tests
testing
├─── fakes
└─── models
```
---
# Licence
Copyright 2025 Rhon Phiri

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
