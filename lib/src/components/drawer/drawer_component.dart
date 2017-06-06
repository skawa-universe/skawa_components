import 'package:angular2/angular2.dart';
import 'package:angular_components/src/model/ui/toggle.dart';

import '../sidebar/sidebar.dart';

/// Drawer is such a sidebar
@Component(
  selector: 'skawa-drawer',
  styleUrls: const ['drawer.css'],
  templateUrl: 'drawer.html',
  host: const {'[class.opened]': 'isOn'},
  inputs: const ['isOn'],
  directives: const [SkawaSidebarComponent, NgClass],
)
class SkawaDrawerComponent extends Toggleable { }
