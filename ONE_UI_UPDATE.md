# Samsung One UI Design Update

## ✅ Implemented Changes

### 1. **Home Screen (Library)**
- **Header**: Implemented a large, collapsible "Library" header using `SliverAppBar` following One UI design principles.
- **Tabs**: Added "Tracks", "Downloads", "Albums", "Artists" tabs.
- **Search**: Integrated a rounded pill-shaped search bar beneath the tabs.
- **Actions**: Added "Shuffle" and "Play All" buttons with purple accent styling.
- **Layout**: Used a `Stack` based architecture to handle the floating player properly.

### 2. **Song List**
- **Clean Design**: Updated `SongCard` to remove card borders and backgrounds.
- **Minimalism**: Now features just the album thumb, text info, and duration (right-aligned).
- **Style**: Matches the clean list look from the reference screenshot.

### 3. **Mini Player**
- **Floating Style**: The mini player now floats above the list content with a subtle shadow.
- **Controls**: Includes Previous, Next, and a distinct circular Play/Pause button.
- **Aesthetics**: Dark gray background (`#1E1E1E`) to stand out from the black app background.

### 4. **Visualizer & Now Playing**
- **PowerAmp Visualizer**: Retained the high-quality 80-bar mirrored spectrum visualizer.
- **Integration**: The transition from the floating mini player to the full screen player is seamless.

## 🎨 Design System
- **Background**: Deep Black (`Colors.black`)
- **Text**: White (Primary), Grey (`Colors.grey[400/500]` Secondary)
- **Accent**: `Colors.purpleAccent` (Tabs, Buttons, Active States)
- **Typography**: Bold headers, clean sans-serif body.

## 🚀 How to Test
1.  **Launch App**: You will see the new "Library" header.
2.  **Scroll**: Scroll down to see the header collapse (One UI behavior).
3.  **Check List**: Notice the cleaner song items with duration.
4.  **Mini Player**: Observe the floating player at the bottom.
5.  **Expand**: Tap the mini player to open the full PowerAmp-style visualizer screen.
