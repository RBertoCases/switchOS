# Releases

### v0.15

  - Added Favorites - Courtesy of [ismaelestalayo](https://github.com/ismaelestalayo/skylineOSP)
      - Toggle highlighted game as Favorite
      - View Favorites List as Sort/Filter option in Software Screen
  - Added ability select Boxart as a Game Background preference in Theme Settings - Courtesy of [ismaelestalayo](https://github.com/ismaelestalayo/skylineOSP)
  - Switched source of Button Prompts - Author/Source: [Zacksly](https://zacksly.itch.io/switch-button-icons-and-controls) Licensed under [CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)
  - improved appearance of battery indicator on HomeScreen on Windows (not perfect, but better)
  - General system stability improvements have been made to enhance the user's experience

### v0.14

- Removed collection controls from homescreen
- Added ability to play background music (See wiki for instructions) - Courtesy of [plaidman](https://github.com/plaidman/retromega-next)
- General system stability improvements have been made to enhance the user's experience

### v0.13.2

- Adjusted ControllerHelpButton spacing for 4x3 resolutions like on RP2
- Changed the number of columns on the SoftwareScreen for non-widescreen resolutions from 3 to 5 based on feedback
- General system stability improvements have been made to enhance the user's experience

### v0.13.1

- Added a Steam Deck controller icon
- General system stability improvements have been made to enhance the user's experience

### v0.13

- Adjusted ControllerHelpButton spacing for 16:10 resolutions
- Added By Publisher Sort Option
- Added a controller icon on the help bar that is responsive to the selected game
- General system stability improvements have been made to enhance the user's experience

### v0.12

- Made Back button controller prompt functional
- Changed button icons to work better with new ability to remap controllers in Pegasus
- Changed Settings Icon
- General system stability improvements have been made to enhance the user's experience

### v0.11

- Changed DropShadows (when enabled) to apply to highlighted items only
- adjusted spacing of All Software button on Home Screen to more closely match that of the actual Switch UI
- General system stability improvements have been made to enhance the user's experience

### v0.10

- Added a battery indicator on the Home Screen along with a setting for displaying the Percentage
- Added a Performance setting for disabling Drop Shadows
- Box art will now be used a last preference for Game Backgrounds
- Fixed a bug causing major lag on RetroPie (tested on Raspberry Pi 4)
- General system stability improvements have been made to enhance the user's experience

### v0.9.4

- Increased MouseArea for the Sort Button on the Software Screen
- General system stability improvements have been made to enhance the user's experience

### v0.9.3

- Disabled the dropshadow on the Software Screen tiles to fix blur
- Fixed mouse/touch functionality on Settings Screen
- General system stability improvements have been made to enhance the user's experience


### v0.9.2

- Added an option to the Settings Screen to set Word Wrap on the highlight titles of the games (On by default)
- Fixed the Fanart option so they actually appear on the Software Screen
- Smoother scrolling on the Software Screen
- General system stability improvements have been made to enhance the user's experience

### v0.9

- Added Settings Screen with the following options:
  - Switch between Screenshots and Fanart as the first preference for game backgrounds
  - Switch time format between 12 and 24 hour formats
- tile assets are now pulled for game tiles if set in metadata (Example: assets.tile: {file.path})
- General system stability improvements have been made to enhance the user's experience

### v0.8

- Moved the Toggle Theme functionality to a menu button on the Home Screen
- The selected Sort Option on the Software Screen is now saved
- Made visual and audio adjustments including adding drop shadows and new sound effects
- General system stability improvements have been made to enhance the user's experience

### v0.7

- Smoother scrolling on the Software Screen @timbiscuits
- Made the Sort, Theme, Prev & Next Collections button prompts clickable for better accessibility
- Behavior change on the game tiles: Now if you have a screenshot, but no logo, game title text does do not appear in the tile. This is useful if you want to set custom artwork as the screenshot that already includes a logo

### v0.6

- Added ability to toggle between light and dark themes

v0.5

- Added sort options on Software Screen
- Fixed Steam logos on Software Screen

### v0.4

- Added "All Software" collection
- List and launch recent last played from platform bar for each collection
- List and launch all last played in software screen for each collection
- changed time to 12 hour format to better match Switch

___

### Forked from switchOS

### v0.3

- Added proper support for variable aspect ratios without decreasing size. Now properly supports 4:3 aspect ratios and should look correct on smaller screens
- Added logos or collection text for missing eslogos
- Fixed issue with navigation audio

### v0.2.2

- Fixed bottom bar alignment on non-16:9 screens

### v0.2.1

- Removed Qt.QML inclusion as it apparently is no longer supported

### v0.2

- Adding new platform logos courtesy of [lilbud](https://github.com/lilbud/es-theme-switch)

### v0.1

- Initial release