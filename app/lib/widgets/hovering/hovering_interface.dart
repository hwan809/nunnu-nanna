abstract class HoveringInterface {
  void show();
  void hide();
  void expand();
  void minimize();
  void updatePosition(Offset position);
}

// 플랫폼별 구현
class AndroidHovering implements HoveringInterface {
  @override
  void show() {
    // SYSTEM_ALERT_WINDOW 사용
  }
  // ... 기타 구현
}

class IOSHovering implements HoveringInterface {
  @override
  void show() {
    // PiP 모드 사용
  }
  // ... 기타 구현
} 