import 'package:flutter/material.dart';
import '../../domain/entities/country_entity.dart';
import '../../core/utils/adaptive_size.dart';

class CountryListItem extends StatelessWidget {
  final CountryEntity country;

  const CountryListItem({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AdaptiveSize.h(6)),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(AdaptiveSize.w(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: AdaptiveSize.w(12),
            offset: Offset(0, AdaptiveSize.h(4)),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(AdaptiveSize.w(16)),
        child: Row(
          children: [
            Container(
              width: AdaptiveSize.w(46),
              height: AdaptiveSize.h(46),
              decoration: BoxDecoration(
                color: Color(0xFF3F51B5).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AdaptiveSize.w(16)),
              ),
              child: Center(
                child: Text(
                  country.commonName.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Color(0xFF3F51B5),
                    fontSize: AdaptiveSize.sp(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(width: AdaptiveSize.w(16)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country.commonName,
                    style: TextStyle(
                      fontSize: AdaptiveSize.sp(20),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: AdaptiveSize.h(4)),
                  Text(
                    country.officialName,
                    style: TextStyle(
                      fontSize: AdaptiveSize.sp(16),
                      color: Color(0xFF333333),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
