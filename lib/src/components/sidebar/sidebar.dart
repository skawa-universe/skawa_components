import 'package:angular/core.dart';
import 'package:angular_components/model/ui/toggle.dart';

/// Sidebar. [See more at](https://material.io/guidelines/layout/structure.html#structure-side-nav)
///
/// __Example usage:__
///     <skawa-sidebar></skawa-sidebar>
///     <skawa-sidebar [isOn]="sidenavIsOpen"></skawa-sidebar>
///     <skawa-sidebar><sidenavHeader></sidenavHeader></skawa-sidebar>
///     <skawa-sidebar><some-cmp></some-cmp></skawa-sidebar>
///     <skawa-sidebar><sidenavFooter></sidenavFooter></skawa-sidebar>
///     <skawa-sidebar><sidenavHeader></sidenavHeader><some-cmp></some-cmp><sidenavFooter></sidenavFooter></skawa-sidebar>
///
/// __Properties:__
/// - `isOn: bool` -- Whether to display the sidebar. Defaults to false.
///
@Component(
  selector: 'skawa-sidebar',
  styleUrls: const ['sidebar.css'],
  templateUrl: 'sidebar.html',
  inputs: const ['isOn'],
  host: const {'[class.opened]': 'isOn'},
)
class SkawaSidebarComponent extends Toggleable {}
