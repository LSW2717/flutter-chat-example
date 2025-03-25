# What You Need

* [Xcode Registry](https://github.com/LSW2717/flutter-template/blob/main/readme/xcode/README.md)

* [Android Studio Registry](https://github.com/LSW2717/flutter-template/blob/main/readme/android_studio/README.md)

* [Flutter Registry](https://github.com/LSW2717/flutter-template/blob/main/readme/flutter/README.md)


____
## 1 Setting
* [Flutter setting](https://github.com/LSW2717/flutter-template/blob/main/README.md)

## 2 Requirement
```
git clone https://github.com/LSW2717/flutter-chat-example.git
```

```
git clone https://github.com/LSW2717/spring-chat-example.git
```
#### flutter-chat-example을 실행하기 위해서는 spring-chat-example을 받아와서 실행하면 되지만 내부 패키지의 종속된 패키지를 가져오기 위해서는 github token이 필요하므로 아래의 docker image를 사용하는 것을 추천한다.

```
docker run -d \
  -p 8080:8080 \
  --name spring-chat-example \
  ghcr.io/lsw2717/spring-chat-example:latest
```
## 3 Start
### 3.1 서버 실행
### 3.2 open IOS simulator OR Android emulator
### 3.3 flutter pub get and run 
```
flutter pub get
```
```
flutter run 
```


