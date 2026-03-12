import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test_project/features/login/controller/login_controller.dart';
import 'package:flutter_test_project/routes/app_routes.dart';
import 'package:flutter_test_project/widgets/custom_dialog.dart';
import 'package:flutter_test_project/widgets/widgets.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const Color _brandColor = Color(0xFF591716);
  static const Color _brandLight = Color(0xFF7A2120);
  static const Color _brandAccent = Color(0xFFB85C5B);
  static const Color _bgColor = Color(0xFFFAF6F5);
  static const Color _cardColor = Colors.white;
  static const Color _textDark = Color(0xFF2A1010);
  static const Color _textMuted = Color(0xFF9E7070);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      appBar: _buildAppBar(),
      body: GetBuilder<LoginController>(
        builder: (controller) {
          final data = controller.userData;
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildProfileHeader(data),
                    SizedBox(height: 24.h),
                    _buildInfoSection(data),
                    SizedBox(height: 16.h),
                    _buildAccountSection(data),
                    SizedBox(height: 32.h),
                    _buildLogoutButton(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _bgColor,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Profile',
        style: TextStyle(
          color: _textDark,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
      leading: IconButton(
        icon: Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: _brandColor.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(Icons.arrow_back_ios_new_rounded,
              color: _brandColor, size: 16.r),
        ),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildProfileHeader(dynamic data) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_brandColor, _brandLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: _brandColor.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar with ring
          Container(
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.6), width: 2.5),
            ),
            child: CircleAvatar(
              radius: 46.r,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: data?.image != null
                    ? Image.network(
                  data!.image!,
                  width: 92.r,
                  height: 92.r,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildAvatarFallback(data),
                )
                    : _buildAvatarFallbackFromName(data),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Full name
          Text(
            data?.fullUserName ?? 'User Name',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),

          SizedBox(height: 4.h),

          // Username with @ prefix
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '@${data?.username ?? 'username'}',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('ID', '#${data?.id ?? '—'}'),
              _buildDivider(),
              _buildStatItem('Gender', _capitalize(data?.gender ?? '—')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.65),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 32.h,
      width: 1,
      color: Colors.white.withOpacity(0.25),
    );
  }

  Widget _buildInfoSection(dynamic data) {
    return _buildSection(
      title: 'Personal Info',
      icon: Icons.person_outline_rounded,
      children: [
        _buildTile(
          icon: Icons.badge_outlined,
          label: 'First Name',
          value: data?.firstName ?? '—',
        ),
        _buildTileDivider(),
        _buildTile(
          icon: Icons.person_pin_outlined,
          label: 'Last Name',
          value: data?.lastName ?? '—',
        ),
        _buildTileDivider(),
        _buildTile(
          icon: Icons.wc_rounded,
          label: 'Gender',
          value: _capitalize(data?.gender ?? '—'),
        ),
      ],
    );
  }

  Widget _buildAccountSection(dynamic data) {
    return _buildSection(
      title: 'Account',
      icon: Icons.manage_accounts_outlined,
      children: [
        _buildTile(
          icon: Icons.alternate_email_rounded,
          label: 'Username',
          value: data?.username ?? '—',
        ),
        _buildTileDivider(),
        _buildTile(
          icon: Icons.email_outlined,
          label: 'Email',
          value: data?.email ?? '—',
        ),
        _buildTileDivider(),
        _buildTile(
          icon: Icons.tag_rounded,
          label: 'User ID',
          value: '#${data?.id ?? '—'}',
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: _brandColor, size: 17.r),
              SizedBox(width: 6.w),
              Text(
                title,
                style: TextStyle(
                  color: _textDark,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: _cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: _brandColor.withOpacity(0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: _brandColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(icon, color: _brandColor, size: 19.r),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: TextStyle(
                    color: _textDark,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTileDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 70.w),
      child: Divider(
        height: 1,
        thickness: 1,
        color: _brandColor.withOpacity(0.07),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: "Do you want to log out your profile?",
              onCancel: () => Get.back(),
              onConfirm: () => Get.offAllNamed(AppRoutes.loginScreen),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 17.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [_brandColor, Color(0xFF8B2626)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: _brandColor.withOpacity(0.38),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout_rounded, color: Colors.white, size: 20.r),
              SizedBox(width: 10.w),
              Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarFallback(dynamic data) {
    return _buildAvatarFallbackFromName(data);
  }

  Widget _buildAvatarFallbackFromName(dynamic data) {
    final initials = data != null
        ? '${data.firstName?.isNotEmpty == true ? data.firstName![0] : ''}${data.lastName?.isNotEmpty == true ? data.lastName![0] : ''}'
        : 'U';
    return Container(
      width: 92.r,
      height: 92.r,
      color: _brandAccent.withOpacity(0.15),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(
            color: _brandColor,
            fontSize: 28.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1).toLowerCase();
  }
}