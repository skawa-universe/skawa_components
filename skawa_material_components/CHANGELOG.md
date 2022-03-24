## 1.5.1

- Added disabled field to the RowData classes


## 1.5.0

- angular updated to the stable 6.0.0 version`

## 1.3.3

- patch version for 6.0.0-alpha

## 1.3.2

- SkawaMaterialBannerComponent renamed to SkawaBannerComponent, added missing styling

## 1.3.1

- patch version for 6.0.0-alpha

## 1.3.0

- From this minor version, there will be a path version for the angular alpha version too
- SkawaMaterialBannerComponent added


## 1.2.2

- Minor styling on SkawaDataTableComponent

## 1.2.1

- added support for Dart 2.5
- CardOverflowDirective added

## 1.2.0

- added support for the dart 2.4 and angular 6.0.0-alpha
- `titleAccessor` added to SkawaDataTableColComponent

## 1.1.0+1

- Fix: SkawaDataTableComponent selectable field has a default value, to evade errors after 2.3 dart version

## 1.1.0

- Pub constraints updated

## 1.0.0+4

- SkawaDataTableComponent columns can be updated at runtime, and coloring won't be messed up after sorting 

## 1.0.0+3

- Pub constraints updated
- ExtendedMaterialIconComponent added

## 1.0.0+2

- SkawaDataTableComponent tests using components with generic parameter 

## 1.0.0+1

- Fixed missing pub constraints

## 1.0.0

- Release to pub

## 1.0.0-beta

- Splitted the original package, removed the non-material components from this package
- RowData now has additional classes filed to be able style them differently

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