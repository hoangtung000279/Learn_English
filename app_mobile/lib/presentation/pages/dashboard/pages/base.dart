import 'package:flutter/material.dart';

class DashboardBaseView extends StatelessWidget {
  const DashboardBaseView({super.key});

  @override
  Widget build(BuildContext context) {
    // Bảng màu chuẩn từ ảnh mẫu
    const Color bgGreen = Color(0xFF8CC63F);
    const Color pathColor = Color(0xFFD4E1A1);
    const Color nodeBlue = Color(0xFF3299FF);

    return Scaffold(
      backgroundColor: bgGreen,
      body: Stack(
        children: [
          /// 1. Lớp trang trí nền (Dòng sông/Bụi cây)
          _buildBackgroundDecor(),

          /// 2. Lộ trình chính (Path + Nodes)
          SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                const height = 1250.0; // Độ dài toàn bộ lộ trình

                return SizedBox(
                  width: width,
                  height: height,
                  child: Stack(
                    children: [
                      // Vẽ đường nối uốn lượn
                      CustomPaint(
                        size: Size(width, height),
                        painter: SmoothPathPainter(pathColor),
                      ),

                      // Danh sách các nút bài học (Căn chỉnh theo tỷ lệ width)
                      _buildNode(context, top: 1000, left: width * 0.72, label: "Greeting", number: "1", stars: 3, color: nodeBlue),
                      _buildNode(context, top: 880, left: width * 0.40, label: "Number", number: "2", stars: 2, color: nodeBlue),
                      _buildNode(context, top: 720, left: width * 0.28, label: "Family", number: "3", stars: 3, color: nodeBlue),
                      _buildNode(context, top: 700, left: width * 0.65, label: "Color", number: "4", stars: 1, color: nodeBlue),
                      _buildNode(context, top: 520, left: width * 0.58, label: "Animal", number: "5", stars: 2, color: nodeBlue),
                      _buildNode(context, top: 500, left: width * 0.22, label: "Nature", number: "6", stars: 1, color: nodeBlue),
                      _buildNode(context, top: 320, left: width * 0.32, label: "Weather", number: "7", stars: 0, color: Colors.orangeAccent),
                      _buildNode(context, top: 300, left: width * 0.68, label: "Plant", number: "8", stars: 0, color: Colors.blueGrey.shade300),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 3. Thanh Header (Stars, Avatar, Streak)
          _buildHeader(),
        ],
      ),

      /// 4. Thanh điều hướng dưới cùng
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ================= THÀNH PHẦN GIAO DIỆN =================

  Widget _buildBackgroundDecor() {
    return Stack(
      children: [
        Positioned(
          top: 600,
          left: -20,
          child: Opacity(
            opacity: 0.25,
            child: Container(
              width: 600,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _headerBadge(Icons.star, "12", Colors.amber),
              Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFC0EBA6)),
                child: const Icon(Icons.pets, color: Colors.green, size: 28),
              ),
              _headerBadge(Icons.local_fire_department, "1", Colors.orange),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerBadge(IconData icon, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 6),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color)),
      ],
    );
  }

  Widget _buildNode(
    BuildContext context, {
    required double top,
    required double left,
    required String label,
    required String number,
    required int stars,
    required Color color,
  }) {
    const double nodeSize = 86.0;

    return Positioned(
      top: top,
      left: left - (nodeSize / 2),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Đổ bóng chân đế (Hiệu ứng 3D)
              Container(
                width: nodeSize,
                height: nodeSize + 6,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black.withOpacity(0.15)),
              ),
              // Vòng tròn chính
              Container(
                width: nodeSize,
                height: nodeSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(color: Colors.white.withOpacity(0.3), width: 4),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Huy hiệu ngôi sao
              if (stars > 0)
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.white),
                        const SizedBox(width: 2),
                        Text("$stars", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.videogame_asset_rounded, color: Colors.blue, size: 32),
            Icon(Icons.qr_code_scanner, color: Colors.grey, size: 28),
            Icon(Icons.school, color: Colors.grey, size: 28),
            Icon(Icons.emoji_events_outlined, color: Colors.grey, size: 28),
          ],
        ),
      ),
    );
  }
}

// ================= VẼ ĐƯỜNG CONG (SMOOTH PATH) =================

class SmoothPathPainter extends CustomPainter {
  final Color color;
  SmoothPathPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final w = size.width;

    // Lộ trình uốn lượn hình chữ S liên tục
    path.moveTo(w * 0.72, 1045);
    path.quadraticBezierTo(w * 0.6, 1045, w * 0.40, 925);
    path.cubicTo(w * 0.2, 850, w * 0.15, 750, w * 0.28, 765);
    path.lineTo(w * 0.65, 745);
    path.cubicTo(w * 0.85, 730, w * 0.85, 550, w * 0.58, 565);
    path.lineTo(w * 0.22, 545);
    path.cubicTo(w * 0.05, 530, w * 0.1, 350, w * 0.32, 365);
    path.lineTo(w * 0.68, 345);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
