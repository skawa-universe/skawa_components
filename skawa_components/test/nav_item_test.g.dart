// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_item_test.dart';

// **************************************************************************
// PageObjectGenerator
// **************************************************************************

// ignore_for_file: private_collision_in_mixin_application
// ignore_for_file: unused_field, non_constant_identifier_names
// ignore_for_file: overridden_fields, annotate_overrides
class $TestPO extends TestPO with $$TestPO {
  PageLoaderElement $__root__;
  $TestPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([CheckTag('test')]);
  }
  factory $TestPO.lookup(PageLoaderSource source) =>
      $TestPO.create(source.byTag('test'));
  static String get tagName => 'test';
}

class $$TestPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  NavItemPO get sideNavItemList {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('TestPO', 'sideNavItemList');
    }
    final element =
        $__root__.createElement(ByTagName('skawa-nav-item'), [], []);
    final returnMe = NavItemPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('TestPO', 'sideNavItemList');
    }
    return returnMe;
  }
}

class $NavItemPO extends NavItemPO with $$NavItemPO {
  PageLoaderElement $__root__;
  $NavItemPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $NavItemPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "NavItemPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "NavItemPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$NavItemPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get rootElement {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('NavItemPO', 'rootElement');
    }
    final element = $__root__;
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('NavItemPO', 'rootElement');
    }
    return returnMe;
  }

  SidebarItemPO get sidebarItemList {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('NavItemPO', 'sidebarItemList');
    }
    final element =
        $__root__.createElement(ByTagName('skawa-sidebar-item'), [], []);
    final returnMe = SidebarItemPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('NavItemPO', 'sidebarItemList');
    }
    return returnMe;
  }
}

class $SidebarItemPO extends SidebarItemPO with $$SidebarItemPO {
  PageLoaderElement $__root__;
  $SidebarItemPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $SidebarItemPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "SidebarItemPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "SidebarItemPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$SidebarItemPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get span {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SidebarItemPO', 'span');
    }
    final element = $__root__.createElement(ByTagName('span'), [], []);
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SidebarItemPO', 'span');
    }
    return returnMe;
  }

  MaterialIconPO get materialIcon {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('SidebarItemPO', 'materialIcon');
    }
    final element = $__root__.createElement(ByTagName('material-icon'), [], []);
    final returnMe = MaterialIconPO.create(element);
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('SidebarItemPO', 'materialIcon');
    }
    return returnMe;
  }
}

class $MaterialIconPO extends MaterialIconPO with $$MaterialIconPO {
  PageLoaderElement $__root__;
  $MaterialIconPO.create(PageLoaderElement currentContext)
      : $__root__ = currentContext {
    $__root__.addCheckers([]);
  }
  factory $MaterialIconPO.lookup(PageLoaderSource source) =>
      throw "'lookup' constructor for class "
      "MaterialIconPO is not generated and can only be used on Page Object "
      "classes that have @CheckTag annotation.";
  static String get tagName =>
      throw '"tagName" is not defined by Page Object "MaterialIconPO". Requires @CheckTag annotation in order for "tagName" to be generated.';
}

class $$MaterialIconPO {
  PageLoaderElement $__root__;
  PageLoaderMouse __mouse__; // ignore: unused_field
  PageLoaderElement get $root => $__root__;
  PageLoaderElement get rootElement {
    for (final __listener in $__root__.listeners) {
      __listener.startPageObjectMethod('MaterialIconPO', 'rootElement');
    }
    final element = $__root__;
    final returnMe = element;
    for (final __listener in $__root__.listeners) {
      __listener.endPageObjectMethod('MaterialIconPO', 'rootElement');
    }
    return returnMe;
  }
}
