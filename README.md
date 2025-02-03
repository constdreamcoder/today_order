# 오늘의주문 - 레스토랑별 주문 앱

<p>
    <img src="https://github.com/user-attachments/assets/8ebc317f-4533-4287-aeae-cb8cc076b8c3" align="center" width="100%"/>
</p>

<br/>

## 구현 예정인 기능

- 상품 목록 화면
- 주문된 상품 목록 화면

<br/>

## 오늘의주문

- 서비스 소개: 각 레스토랑에서 판매되는 음식들을 선택하여 주문할 수 있는 서비스
- 개발 인원: 2인(Flutter 1인, 서버 1인) - Flutter 개발 담당
- 개발 기간: 25.01.28 ~ (진행중)
- 개발 환경
    - 최소버전: AOS 5, iOS 12
- 사용 툴
    - Figma, Git

<br/>

## 💪 주요 기능

- 로그인, 자동 로그인
- 레스토랑 목록 조회
- 레스토랑 상세 조회
- 상품 목록 조회
- 레스토랑 평점 조회
- 장바구니 기능
- 주문 기능

<br/>

## 📱 동작 화면

|로그인|자동 로그인|레스토랑 목록 조회|레스토랑 상세화면 조회|
|:---:|:---:|:---:|:---:|
|![로그인](https://github.com/user-attachments/assets/cc576894-a342-4236-a375-8b17ff48607b)|![자동 로그인](https://github.com/user-attachments/assets/adaed2e9-d0e0-42e9-aeaa-231b927c4947)|![레스토랑 목록 조회](https://github.com/user-attachments/assets/d1c6eab9-fa01-44f8-871e-0e76069b652a)|![레스토랑 상세화면 조회](https://github.com/user-attachments/assets/299dae52-c012-47b5-80d9-a22db887b95a)|

|레스토랑 목록 새로고침|레스토랑 목록 무한스크롤|레스토랑 상세면 무한스크롤|
|:---:|:---:|:---:|
|![레스토랑 목록 새로고침](https://github.com/user-attachments/assets/743a3e1e-b52d-46e9-86b4-5d82b5d2fef1)|![레스토랑 목록 무한스크롤](https://github.com/user-attachments/assets/49c6f0cc-fc87-4ffd-a889-2da43b207f44)|![레스토랑 상세면 무한스크롤](https://github.com/user-attachments/assets/67b2c448-ed80-42c3-a6ed-9170db8ba589)|

|장바구니 추가|장바구니 제거|주문하기|
|:---:|:---:|:---:|
|![장바구니 추가](https://github.com/user-attachments/assets/57c362f0-60ef-4c4c-88c3-c2eb5a77bf14)|![장바구니 제거](https://github.com/user-attachments/assets/bbf36d7a-0527-441d-b415-014a947f07d8)|![주문하기](https://github.com/user-attachments/assets/c5c82e88-9a39-49e4-be73-e73cd8d600bc)|


<br/>

## 🛠 기술 소개

- Flutter
- Riverpod, Clean Architecture
- dio, retrofit, freezed, json_serializable
- flutter_secure_storage, go_router
- get_it, Injectable
- Hero Widget, badges, shimmer, debounce_throttle

<br/>

## 💻 기술 적용

- **Clean Architecture 적용 및 DI 도입**: `Clean Architecture` 적용을 통한 명확한 책임 분리와 `DI` 도입을 통한 객체간 의존성 최소화
- **Riverpod을 활용한 상태 관리**: `Riverpod`을 활용한 상태 관리를 통한 효율적인 의존성 주입과 위젯 트리에 독립적인 상태 관리
- **BaseURL, API 키 보안**: `BaseURL`과 `API 키`를 안전하게 관리하기 위해 `.env` 에 관련 환경 변수 설정
- **Throttle를 활용한 Cursor Pagination 성능 개선**: `Pagination` 동작 중 `3초` 내 연속적인 불필요한 네트워크 방지를 위해 `Trottling` 기법 도입
- **Debounce를 활용한 장바구니 API 중복 호출 방지**: 장바구니 추가/제거 중 일정 시간(`1초`)내 불필요한 중복된 장바구니 추가/제거 API 호출을 방지하기 위해 `Debouncing` 도입
- **Sekeleton View와 Hero Widget 사용으로 UI/UX 개선**: `Sekeleton View`와 `Hero Widget` 사용하여 데이터 로딩 중 사용자에게 로딩 중이라는 사실을 알리는 사용자 경험을 개선
- **Activity Indicator 구현**: 사용자에게 백그라운드 작업이 진행 중임을 알리기 위해 구현
- **Dio, Retrofit을 활용한 네트워크 통신 중앙화**: `Dio`와 `Retrofit` 패키지를 활용하여 네트워크 요청 통신을 구성하는 로직 모듈화
- **Dio와 Interceptor를 활용한 토큰 갱신**: `Interceptor`를 활용하여 토큰 만료를 추적하여 갱신하는 로직 구현
- **Injectable를 활용한 Get_it DI 코드 간소화**: `DI` 코드 간소화를 위해 `Injectable` 패키지 도입
- **안전한 토큰 저장을 위해 Secure Storage 도입**: 안전한 토큰 저장을 위해 `Secure Storage` 패키지 도입
- **Optimistic Response를 활용한 장바구니 UX 개선**: 빠른 장바구니 사용자 경험 개선을 위해 Optimistic Response를 도입

<br/>

## ⚙️ 아키텍처

<img src="https://github.com/user-attachments/assets/9bec13ae-572a-4080-965f-73c8415d1cda" align="image" width="100%"/>

<br/>

## 🗓️ 일정에 맞춰 진행

[개발 일정표 링크](https://rogue-look-260.notion.site/188c0579c161809d8860c783230c0204?pvs=4)

<img src="https://github.com/user-attachments/assets/2930f3f2-c850-495d-841d-555ae985caf0" align="image" width="100%"/>

<br/>
<br/>

## 📌 커밋 메세지 룰입니다. 📌

✔ Feat : 새로운 기능의 추가

✔ Asset : Asset 추가

✔ Fix: 버그 수정

✔ Docs: 문서 수정

✔ Refactor: 코드 리펙토링

✔ Test: 테스트 코드, 리펙토링 테스트 코드 추가

✔ Chore: 빌드 업무 수정, 패키지 매니저 수정(ex .gitignore 수정 같은 경우)
