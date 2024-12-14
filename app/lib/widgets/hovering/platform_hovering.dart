class PlatformHoveringWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return IOSHoveringWidget();
    } else {
      return AndroidHoveringWidget();
    }
  }
} 