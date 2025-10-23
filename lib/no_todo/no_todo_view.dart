part of '../home_page.dart';

class NoToDoView extends StatelessWidget {
  final String appBarTitle;
  const NoToDoView({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        // margin & padding 20 적용하기
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          // 백그라운드 컬러 및 테두리 라운딩에 circular(12) 적용하기
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Column을 이용하여 수직으로 순서대로 배치
          children: <Widget>[
            // 원하는 이미지 (가로&세로 100씩, webp)
            Image.asset(
             'assets/empty.webp', // 경로 설정 확인
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 12), // 각 요소간 간격 12 설정
            
            // 텍스트1(사이즈16, 볼드체 적용)
            const Text(
              "할 일이 없습니다!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12), // 각 요소간 간격 12 설정

            // 텍스트2(사이즈14, 높이 1.5, 가운데 정렬 적용, AppBar에 적용한 title을 받아 사용)
            Text(
              "할 일을 추가하고 $appBarTitle\n에서 할 일을 추적하세요.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // Icon 사용하기 (Icon Class의 add icon 사용)
            // 아이콘은 흰색, 사이즈 24, 배경은 원하는 색상, 버튼 모양은 원형 적용
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[400], // 원하는 색상
                shape: BoxShape.circle, // 버튼 모양은 원형
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.add,
                color: Colors.white, // 아이콘은 흰색
                size: 24, // 사이즈 24
              ),
            ),
          ],
        ),
      ),
    );
  }
}