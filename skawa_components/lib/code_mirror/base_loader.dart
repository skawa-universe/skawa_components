import 'dart:async';
import 'dart:html';

/// this class

class BaseLoader {
  Future<bool> load(LoadedElement linkToLoad,
      {void loadCallback(), void errorCallback(), bool force = false, bool skipCallBack = false}) async {
    if (force) {
      _cleanDom(linkToLoad);
      _removeCachedLoadResult(linkToLoad);
    }
    if (_stillLoading(linkToLoad.linkToLoad)) {
      await _waitForLoad(linkToLoad.linkToLoad);
      await load(linkToLoad,
          loadCallback: loadCallback, errorCallback: errorCallback, force: false, skipCallBack: skipCallBack);
      return false;
    }
    if (_previouslyLoaded(linkToLoad.linkToLoad)) {
      // will still trigger callbacks based on the previous state of script
      if (!skipCallBack) _triggerCallbacks(linkToLoad.linkToLoad, loadCallback, errorCallback);
      return false;
    }
    await _domLoadScript(linkToLoad, loadCallback, errorCallback, skipCallBack);
    return true;
  }

  Future loadList(List<LoadedElement> linkToLoadList,
      {void loadCallback(), void errorCallback(), bool force = false}) async {
//    print('linkToLoadList: ${linkToLoadList.map((LoadedElement elem) => elem.linkToLoad).toList()}');
    await Future.wait(linkToLoadList.map((LoadedElement linkToLoad) => load(linkToLoad,
        loadCallback: loadCallback, errorCallback: errorCallback, force: force, skipCallBack: true))).catchError((_) {
      (errorCallback ?? _noop)();
      linkToLoadList.forEach(_cleanDom);
    });
    loadCallback != null ? loadCallback() : _noop();
  }

  void _triggerCallbacks(String linkToLoad, void loadCallback(), void errorCallback()) {
    // will still trigger callbacks based on the previous state of script
    if (loadCallback != null && _loadedResult[linkToLoad]) loadCallback();
    if (errorCallback != null && !_loadedResult[linkToLoad]) errorCallback();
  }

  Future _waitForLoad(String linkToLoad) => _loadingResult[linkToLoad].first;

  bool _previouslyLoaded(String linkToLoad) => _loadedResult.containsKey(linkToLoad);

  bool _stillLoading(String linkToLoad) => _loadingResult.containsKey(linkToLoad);

  void _cleanDom(LoadedElement linkToLoad) =>
      document.querySelectorAll(linkToLoad.type).where((Element el) => linkToLoad.isSameElement(el)).forEach(_remove);

  void _removeCachedLoadResult(LoadedElement linkToLoad) {
    _loadedResult.remove(linkToLoad.linkToLoad);
    _loadingResult.remove(linkToLoad.linkToLoad);
  }

  Future _domLoadScript(LoadedElement linkToLoad, void loadCallback(), void errorCallback(), bool skipCallBack) async {
    linkToLoad.createNewElement();
    _loadingResult[linkToLoad.linkToLoad] = linkToLoad._element.onLoad;
    Completer loadCompleter = Completer();
    // set listener
    linkToLoad._element.onLoad.listen((_) {
      _loadedResult[linkToLoad.linkToLoad] = true;
      _loadingResult.remove(linkToLoad.linkToLoad);
//      print('loaded: ${linkToLoad.linkToLoad}');
      if (!loadCompleter.isCompleted) loadCompleter.complete();
      if (!skipCallBack) loadCallback != null ? loadCallback() : _noop();
    }).onError((_) {
//      print('error: ${linkToLoad.linkToLoad} || $_');
      errorCallback != null ? errorCallback() : _noop();
    });
    // some trickery - need to append first
    document.head.append(linkToLoad._element);
    linkToLoad.updateElement();
    await loadCompleter.future;
  }

  static void _remove(Element element) => element.remove();

  static void _noop([Event ev]) {}

  /// scripts that are loaded and loadCallbacks are triggered
  static final Map<String, bool> _loadedResult = Map<String, bool>();

  /// scripts are being loaded but loadCallback has not yet triggered
  static final Map<String, Stream> _loadingResult = Map<String, Stream>();
}

abstract class LoadedElement {
  Element _element;

  Element get element => _element;

  String get type;

  String get linkToLoad;

  void createNewElement();

  bool isSameElement(Element el);

  void updateElement();
}

class LinkLoader extends LoadedElement {
  @override
  final String type = 'link';

  @override
  final String linkToLoad;

  LinkLoader(this.linkToLoad);

  @override
  void createNewElement() => _element = LinkElement()..rel = 'stylesheet';

  @override
  bool isSameElement(Element el) => el is LinkElement && el.href == linkToLoad;

  @override
  void updateElement() => (element as LinkElement).href = linkToLoad;
}

class ScriptLoader extends LoadedElement {
  @override
  final String type = 'script';

  @override
  final String linkToLoad;

  ScriptLoader(this.linkToLoad);

  @override
  void createNewElement() => _element = ScriptElement()
    ..defer = true
    ..type = 'application/javascript';

  @override
  bool isSameElement(Element el) => el is ScriptElement && el.src == linkToLoad;

  @override
  void updateElement() => (element as ScriptElement).src = linkToLoad;
}
