import 'package:flutter/material.dart';
import 'dart:async'; // 타이머용

class StudyModeScreen extends StatefulWidget {
  @override
  _StudyModeScreenState createState() => _StudyModeScreenState();
}

class _StudyModeScreenState extends State<StudyModeScreen> {
  bool _isTracking = false;
  bool _isBlinking = false;
  double _eyeOpenness = 1.0;
  Timer? _blinkTimer;
  
  @override
  void initState() {
    super.initState();
    _startDemoTracking();
  }

  void _startDemoTracking() {
    setState(() => _isTracking = true);
    
    // 3초마다 눈 깜빡임 시뮬레이션
    _blinkTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isBlinking = true;
        _eyeOpenness = 0.1;
      });
      
      // 0.5초 후 눈 뜨기
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isBlinking = false;
            _eyeOpenness = 1.0;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 상단 상태 바
            _buildStatusBar(),
            
            // 메인 콘텐츠
            Expanded(
              child: _buildMainContent(),
            ),
            
            // 데모 컨트롤
            _buildDemoControls(),
            
            // 하단 버튼
            _buildControlButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            _isTracking ? Icons.visibility : Icons.visibility_off,
            color: _isTracking ? Color(0xFF7BD3EA) : Colors.grey,
          ),
          SizedBox(width: 8),
          Text(
            _isTracking ? '눈 건강 모니터링 중' : '모니터링 준비 중',
            style: TextStyle(
              fontFamily: 'Cafe24OhSquare',
              fontSize: 16,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 화면으로 이동
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 눈 상태 아이콘
          Icon(
            _isBlinking ? Icons.remove : Icons.remove_red_eye,
            size: 80,
            color: Color(0xFF7BD3EA),
          ),
          SizedBox(height: 24),
          // 상태 텍스트
          Text(
            _isBlinking ? '눈 깜빡임 감지!' : '눈을 뜨고 있음',
            style: TextStyle(
              fontFamily: 'Cafe24OhSquare',
              fontSize: 24,
              color: Color(0xFF7BD3EA),
            ),
          ),
          SizedBox(height: 16),
          // 눈 뜬 정도
          Text(
            '눈 뜬 정도: ${(_eyeOpenness * 100).toStringAsFixed(1)}%',
            style: TextStyle(
              fontFamily: 'Cafe24OhSquare',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // 눈 뜬 정도 조절 슬라이더
          Text(
            '눈 뜬 정도 조절 (데모)',
            style: TextStyle(
              fontFamily: 'Cafe24OhSquare',
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Slider(
            value: _eyeOpenness,
            onChanged: (value) {
              setState(() {
                _eyeOpenness = value;
                _isBlinking = value < 0.3;
              });
            },
            activeColor: Color(0xFF7BD3EA),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // 호버링 위젯으로 전환
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('호버링 모드 준비 중')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7BD3EA),
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              '호버링 모드로 전환',
              style: TextStyle(
                fontFamily: 'Cafe24OhSquare',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _blinkTimer?.cancel();
    super.dispose();
  }
} 