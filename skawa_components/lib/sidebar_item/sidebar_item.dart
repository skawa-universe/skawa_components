import 'package:angular/angular.dart';
import 'package:angular_components/material_icon/material_icon.dart';
import '../util/attribute.dart' as attrib;

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
    styleUrls: ['sidebar_item.css'],
    directives: [MaterialIconComponent, NgIf],
    changeDetection: ChangeDetectionStrategy.OnPush)
class SkawaSidebarItemComponent extends Object with TextOnlyMixin {
  @Input()
  String icon;
}

abstract class TextOnlyMixin {
  @HostBinding('attr.textOnly')
  @Input()
  String textOnly;

  bool get isTextOnly => attrib.isPresent(textOnly);
}
