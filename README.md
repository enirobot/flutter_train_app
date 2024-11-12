
# 기차 예매 앱

## 프로젝트 소개

이 프로젝트는 Flutter를 사용하여 개발된 간단한 기차 예매 앱입니다.

## 주요 기능

- 출발역과 도착역 선택
- 좌석 선택 (A, B, C, D 열 배치)
- 다크 모드 지원
- 예약 완료 확인 페이지

## 프로젝트 구조

```
lib/
├── main.dart
├── pages/
│   ├── home_page.dart
│   ├── station_list_page.dart
│   ├── seat_page.dart
│   └── booking_complete_page.dart
└── models/
    └── station.dart
```

## 설치 방법

1. Flutter 개발 환경 설정이 필요합니다.
2. 프로젝트를 클론합니다:
```bash
git clone https://github.com/enirobot/flutter_train_app
```
3. 프로젝트 디렉토리로 이동:
```bash
cd flutter_train_app
```
4. 의존성 패키지 설치:
```bash
flutter pub get
```
5. 앱 실행:
```bash
flutter run
```

## 주요 화면

### 메인 화면 (HomePage)
- 출발역과 도착역 선택 가능
- 역 선택 시 좌석 선택 페이지로 이동

### 역 선택 화면 (StationListPage)
- 주요 역 목록 표시
- 이미 선택된 역은 목록에서 제외

### 좌석 선택 화면 (SeatPage)
- 다중 좌석 선택 가능
- 선택된 좌석 시각적 표시

### 예약 완료 화면 (BookingCompletePage)
- 예약 정보 확인 (출발역, 도착역, 선택된 좌석)
- 홈 화면으로 돌아가기 기능

## 기술 스택

- Flutter
- Dart