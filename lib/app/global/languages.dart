import 'package:get/get.dart';

class Languages extends Translations {
  @override
  //locale
  Map<String, Map<String, String>> get keys => {
        //en_us는 원래 텍스트와 동일하도록 함.
        'en_US': {
          'Insert here': ' Insert here',
          'Tags': 'Tags',
          'Customizing': 'Customizing',
          'Searching': 'Searching',
          'Search here': ' Search here',
          'Device': 'Device',
          'Light': 'Light',
          'Dark': 'Dark',
          //태그는 중복 패스
          //control view.
          'Deleted Memo': 'Deleted Memo',
          //추후 패치 대비.
          // 'Fonts & Locale': 'Fonts & Locale',
          'Fonts & Locale': 'Languages',
          'Application Info': 'Application Info',
          'Tags Customize': 'Tags Customize',
          //trash view.
          'Recover Memo': 'Recover Memo',
          'Hard Delete': 'Hard Delete',
          'Delete All Items': 'Delete All Items',
          'Are you sure you want to \npermanently delete all items?':
              'Are you sure you want to \npermanently delete all items?',
          'Cancel': 'Cancel',
          'Confirm': 'Confirm',
          //language view.
          'Languages' : 'Languages',
          //Application Info
          'Application Version': 'Application Version',
          'Database Version': 'Database Version',
          'Current Locale': 'Current Locale',
          'Dev Email': 'Dev Email',
          //empty.
          'Deleted Memo\nis Empty': 'Deleted Memo\nis Empty',
          'Memo is Empty': 'Memo is Empty',
          'Can not found Memo': 'Can not find Memo',
          'Tagged in ': 'Tagged in ',
          'Searched in ': 'Searched in ',
          'Please get send button\nTo add Memo':
              'Please get send button\nTo add Memo',
          'The content is empty!' : 'The content is empty!',
          'Please add some content' : 'Please add some text',
          //elevated button
          'Delete Memo': 'Delete Memo',
          'Check Clear': 'Check Clear',
          'Delete Checked Memo': 'Delete Checked Memo',
          //tag snackBar
          'Tag Name Save Complete' : 'Tag Name Save Complete',
          'Tag name saved successfully': 'Tag name saved successfully',
        },
        'en_UK': {
          'Insert here': ' Insert here',
        },
        'ko_KR': {
          'Insert here': ' 메모 입력',
          'Tags': '태그',
          'Customizing': '태그 설정',
          'Searching': '검색하기',
          'Search here': ' 검색어 입력',
          'Device': '설정에 맞게',
          'Light': '라이트',
          'Dark': '다크',
          'Deleted Memo': '삭제한 메모',
          //추후 패치 대비.
          'Fonts & Locale': '언어',
          'Application Info': '애플리케이션 정보',
          'Tags Customize': '태그 설정',
          'Recover Memo': '메모 복구하기',
          'Hard Delete': '메모 영구 삭제',
          'Delete All Items': '모든 메모 영구 삭제',
          'Are you sure you want to \npermanently delete all items?':
              '삭제한 모든 메모를\n영구적으로 삭제하시겠습니까?',
          'Cancel': '취소',
          'Confirm': '확인',
          //languages view.
          'Languages' : '언어 설정',
          //Application Info.
          'Application Version': '애플리케이션 버전',
          'Database Version': '저장소 버전',
          'Current Locale': '현재 적용된 언어',
          'Dev Email': '개발자 연락처',
          //empty
          'Deleted Memo\nis Empty': '삭제한 메모가\n없어요',
          'Memo is Empty': '메모가 비었어요',
          'Can not found Memo': '메모를 찾을수 없어요',
          'Tagged in ': '현재 설정된 태그: ',
          'Searched in ': '현재 설정된 검색어: ',
          'Please get send button\nTo add Memo': '전송 버튼을 눌러\n메모를 추가해주세요',
          'The content is empty!' : '내용이 비어있어요!',
          'Please add some content' : '메모를 입력하려면 내용을 추가해주세요',
          //elevated button
          'Delete Memo': '메모 삭제',
          'Check Clear': '선택 해제',
          'Delete Checked Memo': '선택된 메모 삭제',
          //tag snackBar
          'Tag Name Save Complete' : '태그 이름 저장 완료',
          'Tag name saved successfully': '태그 이름이 성공적으로 저장되었어요',
        },
        'ja_JP': {
          'Insert here': ' Insert here',
        },
      };
}
