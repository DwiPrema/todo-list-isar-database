# 📝 Task Management App (Flutter + Isar)

A simple **Task Management application** built with **Flutter** and **Isar Database**.  
This project is currently in the **initial setup stage** and focuses on ensuring **dependency stability and compatibility**.

---

## 🚀 Tech Stack

- **Flutter**: 3.16.9
- **Dart**: 3.2.6
- **Database**: Isar
- **State Management**: (Not implemented yet)
- **Platform**: Android, iOS, Web, Desktop

---

## 📌 Why Flutter 3.16.9?

This project intentionally uses **Flutter 3.16.9** for the following reasons:

- ✅ **Stable compatibility with Isar 3.x**
- ✅ Avoids Android Gradle Plugin (AGP) namespace issues
- ✅ Prevents breaking changes introduced in newer Flutter versions
- ✅ Ensures consistent behavior across environments

> ⚠️ At the time of development, **Isar is not fully compatible with the latest Flutter versions**.  
> Using Flutter 3.16.9 provides a stable and predictable development experience.

---

## 🔧 Flutter Version Management (FVM)

This project uses **FVM (Flutter Version Management)** to **lock** the Flutter SDK version.

### Required Flutter Version
- 3.16.9
The version is defined in : **.fvmrc**

### Install FVM (if not installed)
```bash
dart pub global activate fvm
```

### Setup The Project
```bash
fvm install
fvm use
fvm flutter pub get
```

### Run The App
```bash
fvm flutter run
```

## 📂 Project Status 

- ✅ Project initialized

- ✅ Flutter & Isar configured

- ✅ UI implementation

- ✅ CRUD features

- ✅ Status Category

This repository currently serves as a clean and stable base project.

## 🧠 Future Plans
- Improve UI & UX

## 📸 App Preview 

| Home | Task List | Create Task | Edit Task |
|-----|---------|----------|----------|
| ![](assets/app_screenshot/Screenshot_1.jpg) | ![](assets/app_screenshot/Screenshot_5.jpg) | ![](assets/app_screenshot/Screenshot_3.jpg) | ![](assets/app_screenshot/Screenshot_4.jpg) |
