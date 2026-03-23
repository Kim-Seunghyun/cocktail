# 🍸 Cocktail Recipe App

칵테일 제조법 기록해보기 (Flutter Application)

---

## 💻 개발 환경 세팅 가이드 (Environment Setup)

이 프로젝트는 Windows와 macOS 양쪽 환경에서 모두 무리 없이 이어서 작업할 수 있도록 설계되었습니다.
새로운 PC에 환경을 구축할 때 각 운영체제에 맞는 터미널에서 아래 명령어들을 실행해 주세요.

### 🍎 macOS (iOS & Android 빌드용)
Mac 터미널(`Terminal`)을 열고 아래 명령어를 순서대로 복사해서 실행하세요.

```bash
# 1. Homebrew (Mac 패키지 관리자) 설치
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Rosetta 설치 (애플 실리콘 M1/M2/M3 칩셋인 경우 속도 및 호환성을 위해 필수)
sudo softwareupdate --install-rosetta --agree-to-license

# 3. 필수 도구(Git, CocoaPods, Flutter SDK) 한 번에 설치
brew install git cocoapods
brew install --cask flutter

# 4. 프로젝트 라이브러리 연동
flutter pub get

# 💡 참고: iOS 빌드를 위해서는 반드시 Mac의 "App Store"에서 'Xcode'를 수동으로 다운로드 후 한 번 실행해서 라이센스에 동의해야 합니다.
```

### 🪟 Windows (Android 기본 환경 구축)
Windows의 `PowerShell`을 **관리자 권한**으로 실행한 뒤 아래 명령어를 사용하세요.

```powershell
# 1. 윈도우 기본 패키지 관리자(winget)를 통해 Git과 Flutter SDK 설치
winget install -e --id Git.Git
winget install -e --id Flutter.Flutter

# 2. Android Studio 설치 (에뮬레이터 및 SDK 세팅을 위함)
winget install -e --id Google.AndroidStudio

# 3. 프로젝트 라이브러리 연동
flutter pub get

# 💡 참고: Android Studio 설치 후 앱을 한 번 실행하여 Android SDK 가이드를 완료해주셔야 합니다. 
```

---

## 🔄 크로스플랫폼 코드 동기화 워크플로우

> ⚠️ 절대로 프로젝트 폴더 전체를 USB나 클라우드(구글 드라이브, 드롭박스 등)로 복사해서 넘기지 마세요! OS별 빌드 파일과 캐시가 섞여서 앱이 빌드되지 않습니다. **반드시 Git(GitHub)을 이용해서 소스 코드만 넘겨야 합니다.**

1. **개발 완료한 PC에서 (예: 작업 후 윈도우)**
```bash
git add .
git commit -m "작업 내용 요약"
git push
```

2. **이어서 작업할 PC에서 (예: 작업 전 맥)**
```bash
git pull
flutter pub get
# 이후 편하게 개발 진행!
```
