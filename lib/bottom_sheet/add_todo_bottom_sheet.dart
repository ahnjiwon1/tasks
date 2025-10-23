part of '../home_page.dart';

class AddToDoBottomSheet extends StatefulWidget {
  const AddToDoBottomSheet({super.key});

  @override
  State<AddToDoBottomSheet> createState() => _AddToDoBottomSheetState();
}

class _AddToDoBottomSheetState extends State<AddToDoBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  bool _isFavorite = false;
  bool _isDescriptionVisible = false;

  @override
  void initState() {
    super.initState();
    // 자동으로 ToDo 추가 창이 뜰 때 키보드가 뜨도록 구현
    // title 입력용 TextField에 focus가 잡히도록 구현
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
    
    // title 입력 변화를 감지하여 저장 버튼 활성화/비활성화
    _titleController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  // ToDo를 저장하는 함수(saveToDo())
  void _saveToDo() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      return; // title이 비었을때는 작동되지 않도록 구현
    }

    final newTodo = ToDoEntity(
      title: title,
      description: _descriptionController.text.trim().isEmpty ? null : _descriptionController.text.trim(),
      isFavorite: _isFavorite,
      isDone: false,
    );
    
    // 저장이 작동되면 ToDo 객체를 반환하고 창 닫기
    Navigator.of(context).pop(newTodo);
  }

  @override
  Widget build(BuildContext context) {
    // 해당 BottomSheet가 키보드 위로 잡히도록 bottom Padding 수정
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      // BottomSheet의 좌우 패딩 20, 위의 패딩 12, 하단 패딩은 0
      padding: EdgeInsets.fromLTRB(20, 12, 20, bottomPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TextField (ToDo title 입력 용)
            TextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: '새 할 일', // hint : 새 할 일
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 16), // 텍스트 사이즈 16
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => _saveToDo(), // 줄바꿈 대신 저장이(saveToDo()) 적용
            ),

            if (_isDescriptionVisible)
              // description 입력용 TextField (줄바꿈 적용)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: '세부정보 추가', // hint : 세부정보 추가
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14), // 텍스트 사이즈 14
                  maxLines: null, // 줄바꿈 적용
                  keyboardType: TextInputType.multiline,
                ),
              ),

            // title 텍스트 입력 창 밑으로 Row를 사용해 Icon 2개 추가하기
            Row(
              children: <Widget>[
                // 설명 Icon
                if (!_isDescriptionVisible)
                  IconButton(
                    icon: const Icon(Icons.short_text_rounded, size: 24), // 설명(short_text_rounded)
                    onPressed: () {
                      setState(() {
                        _isDescriptionVisible = true; // 설명 Icon 을 눌렀을 때, description용 TextField 보이게 하기
                        // TextField 화면 표시 시, description 용 Icon 숨기기
                      });
                    },
                  ),
                
                // 즐겨찾기 Icon
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.star : Icons.star_border, // bool 값을 이용하여 상태 표시
                    size: 24, // 아이콘 사이즈 24
                    color: _isFavorite ? Colors.amber : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isFavorite = !_isFavorite;
                    });
                  },
                ),
                
                const Spacer(), // Row를 이용하여 끝에 ‘저장’ 버튼이 있도록 구현

                // ‘저장’ 버튼
                TextButton(
                  onPressed: _titleController.text.trim().isNotEmpty ? _saveToDo : null,
                  child: Text(
                    '저장',
                    style: TextStyle(
                      // title에 입력된 요소가 있을 때만 활성화(색상 차이 구현)
                      color: _titleController.text.trim().isNotEmpty ? Colors.deepPurple : Colors.grey.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}