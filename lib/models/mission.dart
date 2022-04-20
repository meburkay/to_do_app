class Mission {
  final String title;
  bool isDone;

  Mission(this.title, {this.isDone = false});

  void missionStatus() {
    isDone = !isDone;
  }
}
