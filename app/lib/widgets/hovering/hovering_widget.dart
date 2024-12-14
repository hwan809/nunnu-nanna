class HoveringWidget extends StatefulWidget {
  @override
  State<HoveringWidget> createState() => _HoveringWidgetState();
}

class _HoveringWidgetState extends State<HoveringWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (!_isExpanded) {
      return MinimizedHoveringWidget(
        onTap: () => setState(() => _isExpanded = true),
      );
    }

    return ExpandedHoveringWidget(
      onMinimize: () => setState(() => _isExpanded = false),
    );
  }
} 