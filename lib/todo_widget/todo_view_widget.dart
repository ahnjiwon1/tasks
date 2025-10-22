part of '../home_page.dart';

// 7. ToDoEntity 를 인자로 받는 ToDoView 위젯 만들기
class ToDoView extends StatelessWidget {
  final ToDoEntity todo;
  final VoidCallback onToggleDone;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTap;

  // 7. VoidCallback 을 인자로 받으세요!
  const ToDoView({
    super.key,
    required this.todo,
    required this.onToggleDone,
    required this.onToggleFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // 7. 마진 수직 8
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16), // 7. 패딩 수평 16
        decoration: BoxDecoration(
          color: Colors.white,
          // 7. 라운딩 12
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            // Icon(circle & check_circle) : 버튼이 눌렸을 때 Done 상태 변경
            IconButton(
              icon: Icon(
                todo.isDone ? Icons.check_circle : Icons.circle_outlined,
                color: todo.isDone ? Colors.green : Colors.grey,
                size: 24,
              ),
              onPressed: onToggleDone,
            ),
            
            const SizedBox(width: 12), // 7. 내부 요소들 간 간격 12

            // 텍스트(To Do의 title)
            Expanded(
              child: Text(
                todo.title,
                style: TextStyle(
                  fontSize: 16,
                  // 7. Done 상태에 따라서 취소선 상태 적용
                  decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: todo.isDone ? Colors.grey : Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            
            const SizedBox(width: 12), // 7. 내부 요소들 간 간격 12

            // Icon(star & star_border) : 버튼이 눌렸을 때 Favorite 상태 변경
            IconButton(
              icon: Icon(
                todo.isFavorite ? Icons.star : Icons.star_border,
                color: todo.isFavorite ? Colors.amber : Colors.grey,
                size: 24,
              ),
              onPressed: onToggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}