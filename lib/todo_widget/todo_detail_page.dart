import 'package:flutter/material.dart';
import 'todo_entity.dart';

class ToDoDetailPage extends StatefulWidget {
  final ToDoEntity todo;
  const ToDoDetailPage({super.key, required this.todo});

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  late ToDoEntity _currentTodo;

  @override
  void initState() {
    super.initState();
    // ToDoEntity를 받아서 화면 컨텐츠 채우기
    _currentTodo = widget.todo;
  }

  // favorite 변경 구현하기
  void _toggleFavorite() {
    setState(() {
      _currentTodo = _currentTodo.copyWith(
        isFavorite: !_currentTodo.isFavorite,
      );
    });
    // 뒤로 간 페이지 모두 반영을 위해 Navigator.pop 호출 시 데이터를 반환합니다.
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 뒤로가기 시 변경된 ToDo 객체를 반환하여 이전 페이지(HomePage)에 반영
        Navigator.pop(context, _currentTodo);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _currentTodo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // back button을 통해서 뒤로가기 구현하기
              Navigator.pop(context, _currentTodo);
            },
          ),
          // AppBar에 actions 사용하기 (Favorite 버튼)
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _currentTodo.isFavorite ? Icons.star : Icons.star_border,
                color: _currentTodo.isFavorite ? Colors.amber : Colors.white,
                size: 28,
              ),
              onPressed: _toggleFavorite, // favorite 변경 구현
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Text(
                _currentTodo.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: _currentTodo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                  color: _currentTodo.isDone ? Colors.grey : Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              if (_currentTodo.description != null && _currentTodo.description!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '세부 정보:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentTodo.description!,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        // ToDo 완료 상태 토글 버튼
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: _currentTodo.isDone ? Colors.orange : Colors.green,
          onPressed: () {
            setState(() {
              _currentTodo = _currentTodo.copyWith(isDone: !_currentTodo.isDone);
            });
          },
          label: Text(
            _currentTodo.isDone ? '미완료로 변경' : '완료 처리',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          icon: Icon(_currentTodo.isDone ? Icons.close : Icons.check),
        ),
      ),
    );
  }
}
