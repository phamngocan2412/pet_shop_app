import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class CouponFieldWidget extends StatefulWidget {
  final String? appliedCoupon;
  final Function(String) onApplyCoupon;
  final VoidCallback onRemoveCoupon;

  const CouponFieldWidget({
    Key? key,
    this.appliedCoupon,
    required this.onApplyCoupon,
    required this.onRemoveCoupon,
  }) : super(key: key);

  @override
  State<CouponFieldWidget> createState() => _CouponFieldWidgetState();
}

class _CouponFieldWidgetState extends State<CouponFieldWidget> {
  final TextEditingController _couponController = TextEditingController();
  bool _isExpanded = false;

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appliedCoupon != null) {
      return _buildAppliedCoupon();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'local_offer',
                  color: AppTheme.primary600,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Apply Coupon',
                  style: TextStyle(
                    color: AppTheme.primary600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                CustomIconWidget(
                  iconName:
                      _isExpanded ? 'keyboard_arrow_up' : 'keyboard_arrow_down',
                  color: AppTheme.neutral600,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _couponController,
                  decoration: InputDecoration(
                    hintText: 'Enter coupon code',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  if (_couponController.text.isNotEmpty) {
                    widget.onApplyCoupon(
                        _couponController.text.trim().toUpperCase());
                    _couponController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text('Apply'),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Try codes: WELCOME10, PETLOVER20, FREESHIP',
            style: TextStyle(
              color: AppTheme.neutral500,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAppliedCoupon() {
    String discountText;
    Color badgeColor;

    if (widget.appliedCoupon == "FREESHIP") {
      discountText = "Free Shipping";
      badgeColor = AppTheme.success600;
    } else if (widget.appliedCoupon == "WELCOME10") {
      discountText = "10% Off";
      badgeColor = AppTheme.primary600;
    } else if (widget.appliedCoupon == "PETLOVER20") {
      discountText = "20% Off";
      badgeColor = AppTheme.primary600;
    } else {
      discountText = "Discount Applied";
      badgeColor = AppTheme.primary600;
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.success100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.success600.withAlpha(77)),
      ),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: 'check_circle',
            color: AppTheme.success600,
            size: 20,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coupon Applied',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.success600,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.appliedCoupon!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      discountText,
                      style: TextStyle(
                        color: AppTheme.neutral600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: widget.onRemoveCoupon,
            child: Text(
              'Remove',
              style: TextStyle(
                color: AppTheme.error600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
