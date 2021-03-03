import 'dart:async';

enum TopBarCategory {
  GENERAL,
  BUSINESS,
  ENTERTAINMENT,
  HEALTH,
  SCIENCE,
  SPORTS,
  TECHNOLOGY
}

class TopBarBloc {
  StreamController<TopBarCategory> _topBarController =
      StreamController<TopBarCategory>.broadcast();

  TopBarCategory defaultCategory = TopBarCategory.GENERAL;

  Stream<TopBarCategory> get categoryStream => _topBarController.stream;

  void pilihCategory(int c) {
    switch (c) {
      case 0:
        _topBarController.sink.add(TopBarCategory.GENERAL);
        break;
      case 1:
        _topBarController.sink.add(TopBarCategory.BUSINESS);
        break;
      case 2:
        _topBarController.sink.add(TopBarCategory.ENTERTAINMENT);
        break;
      case 3:
        _topBarController.sink.add(TopBarCategory.HEALTH);
        break;
      case 4:
        _topBarController.sink.add(TopBarCategory.SCIENCE);
        break;
      case 5:
        _topBarController.sink.add(TopBarCategory.SPORTS);
        break;
      case 6:
        _topBarController.sink.add(TopBarCategory.TECHNOLOGY);
    }
  }

  close() {
    _topBarController?.close();
  }
}
