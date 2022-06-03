## 1.5.2

- Fixes CodeMirrorComponent component in case of minified scripts

## 1.5.1

- Made CKEditor change event working

## 1.5.0

- angular updated to the stable 6.0.0 version

## 1.4.0

- New structural directives: `[featureEnabled]` and `[featureDisabled]`

## 1.3.3

- patch version for 6.0.0-alpha

## 1.3.2

- CKEditor can be used with custom config map

## 1.3.1

- patch version for 6.0.0-alpha

## 1.3.0

- From this minor version, there will be a path version for the angular alpha version too
- Performance update on SkawaListWrapperComponent for normal use cases

## 1.2.2

- SkawaForDirective onLoad ouput stream added
- CodeMirrorModeWithLink static constants fixed

## 1.2.1

- added support for Dart 2.5
- CodeMirrorComponent, DiffComponent and SkawaListWrapperComponent added

## 1.1.0

- Pub constraints updated

## 1.0.0+4

- Pub constraints updated

## 1.0.0+3

- Fixed SkawaMarkdownEditorComponent

## 1.0.0+2

- Fixed EditorRenderSource

## 1.0.0+1

- Fixed missing pub constraints

## 1.0.0

- Release to pub

## 1.0.0-beta

- Splitted the original package, removed the material components from this package
- SkawaRandomColorizePipe renamed to SkawaHexColorizePipe
- SkawaAppbarComponent, SkawaDrawerComponent, SkawaSidebarComponent became deprecated

## 1.0.0-alpha+7

- SkawaRawMarkdownRendererComponent added

## 1.0.0-alpha+6

- SkawaMarkdownEditorComponent disable ex improved

## 1.0.0-alpha+5

- SkawaMarkdownEditorComponent can be disabled

## 1.0.0-alpha+4

- Added a new output stream to SkawaMarkdownEditorComponent which emits on displayMode change
- SkawaMarkdownRendererComponent added
- SkawaDataTableComponent non-highlightable mode fixed

## 1.0.0-alpha+3

- SkawaInfobarComponent button open the url in a new tab
- SkawaDataTableComponent can be non highlightable

## 1.0.0-alpha+2

- SkawaMarkdownEditorComponent now updates EditorRenderTarget with the proper classes

## 1.0.0-alpha+1

- fix minor issue in toggleAttribute method
- snackbar_test refactored
- added flaky-on-travis tags to tests which is never fails on localhost but sometimes fails on travis
- moved PromptComponent to lib folder due to Angular4 migration

## 1.0.0-alpha
- Upgrade to Angular4

## 0.0.16
- Added new component <prompt>

## 0.0.15

- Added new component `<skawa-markdown-editor>` and corresponding Directives.
- Ckeditor description corrected
- analysis_options became stricter
- travis script now running dartfmt, if the code is not formated properly then exit

## 0.0.14
- Added tests to snackbar
- Changed angular2 version from  ^3.1.0 to 3.1.0

## 0.0.13
- Added SkawaRandomColorizePipe

## 0.0.12
- Added sort logic to SkawaDataTableComponent

## 0.0.11
- Modified snackbar to use material popup.
- Snackbar should now be in the bottom left corner of the screen always.
- Changed angular_components version from "^0.5.1" to "^0.5.3+1"

## 0.0.10

- DataTable highlight event won't be triggered when selector checkbox is clicked

## 0.0.9

- Changed to `DataTable`
  - introduction of the concept of `primaryAction`. Columns with accessors can subscript to `(trigger)`
    action.
  - rows can be `(highlight)`-ed without making a change in selection

## 0.0.8+1

- Fixed a strong-mode error about missing trigger on Snackbar
- Changed `DataTableAccessor` return value from `dynamic` to `String`

## 0.0.8

- Add `SnackbarComponent`

## 0.0.7

- Add some new functionality to `<skawa-data-table>`:
  - `change` event is emitted when selection changes
  - setting `multiSelection` toggles whether only a single or multiple elements can be selected  
   
## 0.0.6+1

-  fixed an issue where dart2js would warn about `??` in for loop

## 0.0.6

- Added support for column renderer for `<data-table>`

## 0.0.5

- Added new component `<skawa-grid>`

## 0.0.4

- CKEditor accepts initial value as `content` input property

## 0.0.3+1

- Fixed transformer usage

## 0.0.3

- Added new component `<skawa-ckeditor>`

## 0.0.2

- Added tests with travis integration
- Minor changes to components and their styling