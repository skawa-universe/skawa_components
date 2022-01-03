import 'package:angular/angular.dart';

/// The three following Directive should be used only inside a SkawaCardHeaderComponent.
/// The [SkawaCardHeaderTitleDirective] should contain the title.
/// The [SkawaCardHeaderSubheadDirective] should contain the subheader.
/// The [SkawaCardHeaderImageDirective] should contain an image.
///
/// __Example:__
///
///     <skawa-card>
///       <skawa-card-header>
///         <skawa-header-image>
///           <material-icon icon="android"></material-icon>
///         </skawa-header-image>
///         <skawa-header-title>
///            The card title.
///         </skawa-header-title>
///         <skawa-header-subhead>
///             <some-cmp>
///             </some-cmp>
///         </skawa-header-subhead>
///       </skawa-card-header>
///     </skawa-card>
///
@Directive(selector: 'skawa-header-title')
class SkawaCardHeaderTitleDirective {}

@Directive(selector: 'skawa-header-subhead')
class SkawaCardHeaderSubheadDirective {}

@Directive(selector: 'skawa-header-image')
class SkawaCardHeaderImageDirective {}
