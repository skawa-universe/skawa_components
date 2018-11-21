//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//part of 'markdown_editor_test.dart';
//
//// **************************************************************************
//// PageObjectGenerator
//// **************************************************************************
//
//// ignore_for_file: private_collision_in_mixin_application
//// ignore_for_file: unused_field, non_constant_identifier_names
//// ignore_for_file: overridden_fields, annotate_overrides
//class $MarkdownEditorPage extends MarkdownEditorPage with $$MarkdownEditorPage {
//  PageLoaderElement $__root__;
//  $MarkdownEditorPage.create(PageLoaderElement currentContext)
//      : $__root__ = currentContext {
//    $__root__.addCheckers([CheckTag('markdown-test')]);
//  }
//  factory $MarkdownEditorPage.lookup(PageLoaderSource source) =>
//      $MarkdownEditorPage.create(source.byTag('markdown-test'));
//  static String get tagName => 'markdown-test';
//  Future editMarkdown() {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('MarkdownEditorPage', 'editMarkdown');
//    }
//    final returnMe = super.editMarkdown();
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('MarkdownEditorPage', 'editMarkdown');
//    }
//    return returnMe;
//  }
//}
//
//class $$MarkdownEditorPage {
//  PageLoaderElement $__root__;
//  PageLoaderMouse __mouse__; // ignore: unused_field
//  PageLoaderElement get $root => $__root__;
//  PageLoaderElement get markdownContainerDiv {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod(
//          'MarkdownEditorPage', 'markdownContainerDiv');
//    }
//    final element =
//        $__root__.createElement(First(ByClass('markdown-container')), [], []);
//    final returnMe = element;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod(
//          'MarkdownEditorPage', 'markdownContainerDiv');
//    }
//    return returnMe;
//  }
//
//  TextAreaElement get textarea {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('MarkdownEditorPage', 'textarea');
//    }
//    final element = $__root__.createElement(ByTagName('textarea'), [], []);
//    final returnMe = TextAreaElement.create(element);
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('MarkdownEditorPage', 'textarea');
//    }
//    return returnMe;
//  }
//
//  PageObjectList<PageLoaderElement> get buttons {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('MarkdownEditorPage', 'buttons');
//    }
//    final returnMe = PageObjectList<PageLoaderElement>(
//        $__root__.createList(ByTagName('button'), [], []),
//        (PageLoaderElement e) => e);
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('MarkdownEditorPage', 'buttons');
//    }
//    return returnMe;
//  }
//}
//
//class $TextAreaElement extends TextAreaElement with $$TextAreaElement {
//  PageLoaderElement $__root__;
//  $TextAreaElement.create(PageLoaderElement currentContext)
//      : $__root__ = currentContext {
//    $__root__.addCheckers([]);
//  }
//  factory $TextAreaElement.lookup(PageLoaderSource source) =>
//      throw "'lookup' constructor for class "
//      "TextAreaElement is not generated and can only be used on Page Object "
//      "classes that have @CheckTag annotation.";
//  static String get tagName =>
//      throw '"tagName" is not defined by Page Object "TextAreaElement". Requires @CheckTag annotation in order for "tagName" to be generated.';
//  String get innerText {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TextAreaElement', 'innerText');
//    }
//    final returnMe = super.innerText;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TextAreaElement', 'innerText');
//    }
//    return returnMe;
//  }
//
//  bool get displayed {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TextAreaElement', 'displayed');
//    }
//    final returnMe = super.displayed;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TextAreaElement', 'displayed');
//    }
//    return returnMe;
//  }
//
//  PageLoaderAttributes get seleniumAttributes {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TextAreaElement', 'seleniumAttributes');
//    }
//    final returnMe = super.seleniumAttributes;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TextAreaElement', 'seleniumAttributes');
//    }
//    return returnMe;
//  }
//
//  Future typing(String input) {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TextAreaElement', 'typing');
//    }
//    final returnMe = super.typing(input);
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TextAreaElement', 'typing');
//    }
//    return returnMe;
//  }
//}
//
//class $$TextAreaElement {
//  PageLoaderElement $__root__;
//  PageLoaderMouse __mouse__; // ignore: unused_field
//  PageLoaderElement get $root => $__root__;
//  PageLoaderElement get rootElement {
//    for (final __listener in $__root__.listeners) {
//      __listener.startPageObjectMethod('TextAreaElement', 'rootElement');
//    }
//    final element = $__root__;
//    final returnMe = element;
//    for (final __listener in $__root__.listeners) {
//      __listener.endPageObjectMethod('TextAreaElement', 'rootElement');
//    }
//    return returnMe;
//  }
//}
