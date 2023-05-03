# MC2-morning-Team12-DreamLog

# Convention

## git branch convention
Branch를 생성하기 전 Issue를 먼저 작성한다.

<Prefix>/#<Issue_Number> 의 양식에 따라 브랜치 명을 작성한다.

- develop : feature 브랜치에서 구현된 기능들이 merge될 브랜치. default 브랜치이다.
- feature : 기능을 개발하는 브랜치, 이슈별/작업별로 브랜치를 생성하여 기능을 개발한다
- main : 개발이 완료된 산출물이 저장될 공간
- release : 릴리즈를 준비하는 브랜치, 릴리즈 직전 QA 기간에 사용한다
- bug : 버그를 수정하는 브랜치
- hotfix : 정말 급하게, 제출 직전에 에러가 난 경우 사용하는 브렌치

<br>
<br>

## 커밋컨벤션

[prefix] #이슈번호 - 이슈 내용

[Feat]: 새로운 기능 구현
[Setting]: 기초 세팅 관련
[Design]: just 화면. 레이아웃 조정
[Fix]: 버그, 오류 해결, 코드 수정
[Add]: Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 View 생성
[Del]: 쓸모없는 코드, 주석 삭제
[Refactor]: 전면 수정이 있을 때 사용합니다
[Remove]: 파일 삭제
[Chore]: 그 이외의 잡일/ 버전 코드 수정, 패키지 구조 변경, 파일 이동, 파일이름 변경
[Docs]: README나 WIKI 등의 문서 개정
[Comment]: 필요한 주석 추가 및 변경
[Merge]: 머지


<br>
<br>

## Working Flow

2. local main 에서 upstream을 풀 받고, origin develop 에 올려준다
    git switch main
    git pull upstream develop
    git push origin develop -> 안 됨.

3. 레포에 이슈를 생성한다.  ( 이슈 템플릿에 맞춰서 )
    "[Prefix] 작업 목표"
    자기 라벨 + Prefix 라벨 선택
    ex) [Design] Weather View 디자인
    4. 이슈 번호 만들어진걸 확인하고 로컬에 feature/#이슈번호 브랜치를 판다
    git switch -c [브랜치명]

5. 작업 하기
    git add
    git commit

6. 충돌 해결 후 PR 올리기
    git pull upstream develop
        충돌이 났다면 크라켄으로 해결해주자!!
    git push origin [작업 브랜치명]
    코드리뷰 해쥬기
    approve 최소 한 명으로 제한 걸어놨음!!

7. 머지하기
       
8. 내 노트북의 작업공간으로 돌아오기
    git checkout develop (main)
    다시 2번부터 진행

<br>
<br>

## 기타 

### 이슈 팔 때

- [Prefix] 뷰이름 이슈명
- 우측 상단 Assignees 자기 자신 선택
- Labels Prefix와 자기 자신 선택

### PR 날릴 때

- Reviewers 자신 제외 2명 체크
- Assignees 자기 자신 추가
- Labels 이슈와 동일하게 추가
- 서로 코드리뷰 꼭 하기
- 수정 필요 시 수정하기
