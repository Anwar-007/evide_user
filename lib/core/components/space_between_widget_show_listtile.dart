import 'package:evide_user/core/utils/app_imports.dart';

class SpaceBetweenWidgetShowListTIle extends StatelessWidget {
  const SpaceBetweenWidgetShowListTIle({
    super.key,
    required this.leadingtext,
    required this.trialingText,
    this.trailingTextStyle,
    this.leadingTextStyle,
    this.onTap,
  });
  final String leadingtext;
  final String trialingText;
  final TextStyle? trailingTextStyle;
  final TextStyle? leadingTextStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        leadingtext,
        style: leadingTextStyle ??
            AppCommonStyles.commonTextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
      ),
      trailing: GestureDetector(
        onTap: onTap,
        child: Text(
          trialingText,
          style: trailingTextStyle ??
              AppCommonStyles.commonTextStyle(
                fontSize: 10.sp,
                color: Colors.purple,
              ),
        ),
      ),
    );
  }
}
