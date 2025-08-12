# MoreYourBong 🚀

**MoreYourBong**은 지역 기반 모임 플랫폼으로, 사용자들이 특정 지역에서 모임을 만들고 참여할 수 있는 Flutter 기반 모바일 애플리케이션입니다.

## 👥 멤버 구성
| 이름 (역할)  |  담당 업무                                    |
|--------------|-----------------------------------------------|
| 이영상 (팀장) |  웰컴 페이지, 모임 생성 페이지, 시연 영상 제작   |
| 김영민 (팀원) |  앱 디자인, 모임 리스트 페이지, 발표 자료        |
| 임기환 (팀원) |  채팅 페이지, 발표                             |

## 📱 주요 기능

### 🎯 핵심 기능
- **지역 기반 모임 생성**: 현재 위치를 기반으로 모임을 만들고 참여
- **실시간 채팅**: 모임별 실시간 채팅 기능
- **사용자 프로필**: 프로필 이미지, 이름, 주소 정보 관리
- **위치 서비스**: GPS 기반 현재 위치 자동 설정

### 🔧 기술적 특징
- **크로스 플랫폼**: Android, iOS
- **실시간 데이터베이스**: Firebase Firestore를 통한 실시간 데이터 동기화
- **상태 관리**: Riverpod을 사용한 효율적인 상태 관리
- **반응형 UI**: Material Design 기반의 직관적인 사용자 인터페이스

## 🏗️ 프로젝트 구조

```
lib/
├── constants/          # 앱 색상 등 상수 정의
├── models/            # 데이터 모델
│   ├── party_model.dart    # 모임 모델
│   ├── user_model.dart     # 사용자 모델
│   └── chat_model.dart     # 채팅 모델
├── repositories/      # 데이터 접근 계층
│   ├── party_repository.dart
│   ├── user_repository.dart
│   ├── chat_repository.dart
│   └── storage_repository.dart
├── services/          # 외부 서비스 연동
│   ├── location_service.dart
│   └── vworld_service.dart
├── viewmodels/        # 비즈니스 로직
│   ├── party_view_model.dart
│   ├── user_view_model.dart
│   ├── chat_view_model.dart
│   └── global_user_view_model.dart
├── views/             # UI 화면
│   ├── pages/
│   │   ├── welcome_page/      # 시작 페이지
│   │   ├── party_list/        # 모임 목록
│   │   ├── create_party_page.dart
│   │   └── chat/              # 채팅 페이지
│   └── widgets/               # 재사용 가능한 위젯
└── utils/             # 유틸리티 함수
```

## 🚀 시작하기

### 필수 요구사항
- Flutter SDK 3.4.1 이상
- Dart SDK
- Firebase 프로젝트 설정

### 설치 및 실행

1. **프로젝트 클론**
   ```bash
   git clone [repository-url]
   cd moreyourbong
   ```

2. **의존성 설치**
   ```bash
   flutter pub get
   ```

3. **Firebase 설정**
   - `firebase_options.dart` 파일이 올바르게 설정되어 있는지 확인
   - Android: `android/app/google-services.json` 파일 확인
   - iOS: `ios/Runner/GoogleService-Info.plist` 파일 확인

4. **앱 실행**
   ```bash
   flutter run
   ```

## 📦 주요 의존성

### 핵심 패키지
- **flutter_riverpod**: 상태 관리
- **firebase_core**: Firebase 핵심 기능
- **cloud_firestore**: 실시간 데이터베이스
- **firebase_storage**: 파일 저장소
- **geolocator**: 위치 서비스
- **geocoding**: 주소 변환
- **image_picker**: 이미지 선택
- **http**: HTTP 요청
- **intl**: 국제화 및 날짜 포맷팅

## 🔐 Firebase 설정

이 프로젝트는 Firebase를 백엔드로 사용합니다:

- **Firestore**: 모임, 사용자, 채팅 데이터 저장
- **Storage**: 프로필 이미지 및 채팅 이미지 저장
- **Authentication**: 사용자 인증 (향후 구현 예정)

## 📱 화면 구성

### 1. Welcome Page
- 사용자 프로필 설정 (이름, 주소, 프로필 이미지)
- 현재 위치 자동 설정
- 앱 시작을 위한 기본 정보 입력

<img width="386" height="894" alt="image" src="https://github.com/user-attachments/assets/d2c18268-269b-40a6-89c3-12b4c3945cad" />  <img width="386" height="894" alt="image" src="https://github.com/user-attachments/assets/4c87d05b-ad2f-4fea-bc4b-400e2d93df16" />




### 2. Party List Page
- 선택된 지역의 모임 목록 표시
- 새 모임 생성 버튼
- 지역별 모임 필터링

<img width="386" height="894" alt="image" src="https://github.com/user-attachments/assets/d0adfebd-104e-486e-8d2f-d5437910d0c1" />




### 3. Create Party Page
- 모임 이름 및 설명 입력
- 선택된 지역에 모임 생성
- Firebase에 모임 정보 저장

<img width="386" height="894" alt="image" src="https://github.com/user-attachments/assets/45665b41-58be-4955-acc9-8c7b171f7a07" />




### 4. Chat Page
- 모임별 실시간 채팅
- 텍스트 및 이미지 메시지 지원
- 메시지 시간 표시
- 자동 스크롤 기능

<img width="386" height="894" alt="image" src="https://github.com/user-attachments/assets/130c887b-b9ac-4de0-b8d7-aabc0a05167b" />




## 🎨 UI/UX 특징

- **Material Design**: Google의 Material Design 가이드라인 준수
- **반응형 레이아웃**: 다양한 화면 크기에 대응
- **직관적인 네비게이션**: 사용자 친화적인 화면 전환
- **한국어 지원**: 한국어 날짜 포맷팅 및 메시지

## 🔧 개발 환경

- **IDE**: VS Code, Android Studio, IntelliJ IDEA
- **플랫폼**: Android, iOS
- **백엔드**: Firebase (Firestore, Storage)
- **상태 관리**: Riverpod
- **아키텍처**: MVVM 패턴

## 📋 향후 개발 계획

- [ ] 사용자 인증 시스템
- [ ] 모임 검색 및 필터링
- [ ] 푸시 알림
- [ ] 모임 참여/탈퇴 기능
- [ ] 사용자 평가 시스템

---

**MoreYourBong**으로 더 많은 사람들과 의미 있는 모임을 만들어보세요! 🎉
