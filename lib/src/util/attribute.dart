library skawa_components.utils;

/// Decides if an attribute is present or missing
///
/// __Example:__
///     @Component(
///       host: const { '[attr.someInput]': 'someInput' }
///     )
///     class SomeComponent{
///       @Input('[attr.someInput]')
///       var someInput;
///       bool get isSomeInput => isPresent(someInput);
///     }
bool isPresent(String input) => input != null;

/// Toggles attribute
///
/// __Example:__
///
///     @Component(/*...*/)
///     class SomeComponent{
///       @Input('[attr.someInput]')
///       var someInput;
///       bool get isSomeInput => isPresent(someInput);
///
///       void toggle() {
///         toggleAttribute(someInput);
///       }
///     }
bool toggleAttribute(String val) {
  // In Angular, an attribute is removed if it's value is `null` and added
  // if it's anything else, like
  return isPresent(val) ? val = null : true;
}
