import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/countries_provider.dart';
import '../../core/utils/adaptive_size.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: AdaptiveSize.w(20),
            vertical: AdaptiveSize.h(16),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AdaptiveSize.w(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: AdaptiveSize.w(20),
                offset: Offset(0, AdaptiveSize.h(8)),
              ),
            ],
          ),
          child: Consumer<CountriesProvider>(
            builder: (context, provider, child) {
              return TextField(
                controller: _textController,
                focusNode: _focusNode,
                onChanged: provider.setSearchQuery,
                decoration: InputDecoration(
                  hintText: 'Search countries...',
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: AdaptiveSize.sp(16),
                  ),
                  prefixIcon: Container(
                    margin: EdgeInsets.all(AdaptiveSize.w(12)),
                    padding: EdgeInsets.all(AdaptiveSize.w(8)),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3F51B5).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AdaptiveSize.w(8)),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Color(0xFF3F51B5),
                      size: AdaptiveSize.w(20),
                    ),
                  ),
                  suffixIcon: provider.searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _textController.clear();
                            provider.clearSearch();
                            _focusNode.unfocus();
                          },
                          icon: Container(
                            padding: EdgeInsets.all(AdaptiveSize.w(4)),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFF6B6B,
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(
                                AdaptiveSize.w(8),
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Color(0xFFFF6B6B),
                              size: AdaptiveSize.w(16),
                            ),
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AdaptiveSize.w(16)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AdaptiveSize.w(20),
                    vertical: AdaptiveSize.h(16),
                  ),
                ),
                style: TextStyle(
                  fontSize: AdaptiveSize.sp(16),
                  color: Color(0xFF1A1A1A),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
