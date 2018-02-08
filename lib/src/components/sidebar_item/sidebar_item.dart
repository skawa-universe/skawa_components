import 'package:angular2/angular2.dart';
import 'package:angular_components/src/components/glyph/glyph.dart';
import '../../util/attribute.dart' as attrib;

/// Toolbar item. See more [about normal lists](https://material.io/guidelines/components/lists.html#) or
/// [about control lists](https://material.io/guidelines/components/lists-controls.html)
/// *Note:* Sidebar is not yet fully implemented. Currently only support use within a Drawer. Please see [#123](plans for sidebar)
///
/// __Example usage:__
///     <skawa-toolbar-item>No icon, with icon placeholder</skawa-toolbar-item>
///     <skawa-toolbar-item [icon]="'home'">Will have icon</skawa-toolbar-item>
///     <skawa-toolbar-item textOnly>No icon, without icon placeholder</skawa-toolbar-item>
///
/// __Properties:__
///
/// - `icon` -- Optional icon to display next to display text, leaving it's place as placeholder.
///
/// __Attributes:__
///
/// - `textOnly` -- If present, `icon` will be ignored and it's place removed.
///
@Component(
    selector: 'skawa-sidebar-item',
    templateUrl: 'sidebar_item.html',
    styleUrls: const ['sidebar_item.css'],
    changeDetection: ChangeDetectionStrategy.OnPush,
    inputs: const ['icon', 'textOnly'],
    directives: const [GlyphComponent, NgIf, NgClass],
    host: const {'[attr.textOnly]': 'textOnly'})
class SkawaSidebarItemComponent extends Object with TextOnlyMixin {
  String icon;
}

abstract class TextOnlyMixin {
  var textOnly;

  bool get isTextOnly => attrib.isPresent(textOnly);
}
