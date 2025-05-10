import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class OrderSummaryWidget extends StatefulWidget {
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final bool isExpanded;

  const OrderSummaryWidget({
    Key? key,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.buttonText,
    required this.onButtonPressed,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  void didUpdateWidget(OrderSummaryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isExpanded != widget.isExpanded) {
      setState(() {
        _isExpanded = widget.isExpanded;
      });
    }
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: _toggleExpanded,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Summary',
                      style: AppTheme.lightTheme.textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total: \$${widget.total.toStringAsFixed(2)}',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primary700,
                          ),
                        ),
                        SizedBox(width: 4),
                        CustomIconWidget(
                          iconName: _isExpanded ? 'expand_less' : 'expand_more',
                          color: AppTheme.neutral600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AnimatedCrossFade(
              firstChild: SizedBox(height: 0),
              secondChild: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildSummaryRow(
                        'Subtotal', '\$${widget.subtotal.toStringAsFixed(2)}'),
                    _buildSummaryRow(
                        'Tax', '\$${widget.tax.toStringAsFixed(2)}'),
                    _buildSummaryRow(
                      'Shipping',
                      widget.shipping == 0
                          ? 'FREE'
                          : '\$${widget.shipping.toStringAsFixed(2)}',
                      valueColor:
                          widget.shipping == 0 ? AppTheme.success600 : null,
                    ),
                    Divider(),
                    _buildSummaryRow(
                      'Total',
                      '\$${widget.total.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(milliseconds: 300),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: widget.onButtonPressed,
                child: Text(widget.buttonText),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isBold
                ? AppTheme.lightTheme.textTheme.titleMedium
                : AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          Text(
            value,
            style: isBold
                ? AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: valueColor ?? AppTheme.primary700,
                  )
                : AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ],
      ),
    );
  }
}
