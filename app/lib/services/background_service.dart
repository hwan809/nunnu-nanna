class BackgroundService {
  static Future<void> start() async {
    // 포그라운드 서비스 시작
    await FlutterForegroundTask.startService(
      notificationTitle: '눈 건강 모니터링 중',
      notificationText: '학습 중 눈 건강을 관리하고 있습니다',
      callback: startCallback,
    );
  }

  // 백그라운드에서 실행될 콜백
  static void startCallback() {
    // ML 서비스 실행
    // 눈 추적 시작
    // 데이터 수집
  }
} 