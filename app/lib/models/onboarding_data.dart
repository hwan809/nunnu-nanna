// lib/models/onboarding_data.dart  
class OnboardingData {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

// 첫 페이지 데이터만 추가
final List<OnboardingData> onboardingPages = [
  const OnboardingData(
    title: '눈 깜빡임 주기와\n패드와 눈 사이 거리 관리',
    subtitle: '내 눈에 맞는 최적의 습관을 찾아보아요',
    imagePath: 'assets/images/onboard_1.svg',
  ),

  const OnboardingData(
    title: '일정 시간마다\n따라하며 배우는 눈 스트레칭',
    subtitle: '15종류의 엄선된 눈 운동을 내 입맛대로 골라요',
    imagePath: 'assets/images/onboard_2.svg',
  ),

  const OnboardingData(
    title: '눈 움직임과 스트레칭을 모아\nAI 눈 건강 지표 통계',
    subtitle: '인식된 눈 움직임으로 건강 통계를 확인해요',
    imagePath: 'assets/images/onboard_3.svg',
  ),

  const OnboardingData(
    title: '눈이 눈누난나~ 할 때마다\n쌓이는 눈누 포인트',
    subtitle: '미션을 수행하고 눈누를 모아서 캐릭터를 구매해요',
    imagePath: 'assets/images/onboard_4.svg',
  ),
];