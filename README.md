 # Attendrix
 ## What is Attendrix?
 **Attendrix revolutionises how students manage academics** — seamlessly blending attendance tracking, personalised scheduling, study resources, and engaging gamification. Built on modern full-stack tech, it brings automation and clarity to daily academic life.
> 
<p align="center">
  <img src="https://img.shields.io/github/stars/sh1shank/attendrix?style=for-the-badge" alt="GitHub stars" />
  <img src="https://img.shields.io/github/license/sh1shank/attendrix?style=for-the-badge&color=purple" alt="Apache 2.0 License" />
   <img src="https://img.shields.io/github/v/tag/sh1shank/attendrix?style=for-the-badge&color=orange" alt="Current Version" />
</p>

---
## Download Attendrix
<div align="center">
Latest Release (Currently in Public Beta!)
 
[![Download APK](https://img.shields.io/badge/Download-Latest%20APK-6366F1?style=for-the-badge&logo=android&logoColor=white)](https://github.com/SH1SHANK/attendrix/releases/latest/download/Attendrix_Release_v1.0.0.apk)

</div>

---

 
## 🌟 Key Features

### 📚 **Smart Course Management**
- **Automatic Course Assignment**: Attendrix intelligently assigns core courses based on your semester and branch
- **Flexible Elective Selection**: Choose electives that align with your academic goals and interests
- **Institute Slot Integration**: Seamlessly integrates with NIT Calicut's official slot system for accurate scheduling

### 🏫 **Dynamic Class Management**
- **Custom Class Creation**: Create personalized classes with custom slots and timings
- **Institute Slot Support**: Utilise existing NIT Calicut time slots for standardised scheduling
- **Real-time Schedule Updates**: Stay updated with any changes to your class schedule

### 📝 **Academic Tracking**
- **Assignment Management**: Track current assignments with due dates and submission status
- **Exam Notifications**: Get notified about upcoming exams for your enrolled courses
- **Grade Tracking**: Record and monitor your marks for assignments and exams
- **Personal Notes**: Add custom notes and reminders to specific classes

### 🔔 **Intelligent Notifications**
- **Flexible Timing**: Set class notifications up to 2 hours before class starts
- **Smart Cancellation Detection**: AI-powered system detects class cancellations automatically
- **User Feedback Integration**: Report class cancellations to help improve the system's accuracy

### 🤖 **Advanced Prediction System**
- **Honor Score Algorithm**: Dynamic user-specific scoring based on reporting accuracy
- **Multi-factor Analysis**: Considers enrollment numbers, historical data, and user reliability
- **Automated Decisions**: Intelligent class cancellation without admin intervention

### 🎯 **Gamified Attendance**
- **Point Rewards**: Earn points for attending classes and maintaining streaks
- **Streak System**: Build and maintain daily attendance streaks
- **Weekly & Monthly Challenges**: Unique, personalized challenges for every user
- **Fair Rewards**: Equal earning potential across all users despite different challenges

### 🛡️ **Anti-Cheat Protection**
- **Integrity Monitoring**: Robust system to prevent attendance manipulation
- **Progress Penalties**: Users lose progress for marking attended classes as absent
- **Fair Play Enforcement**: Maintains the integrity of the gamification system

### 📚 **Personalized Study Hub**
- **Course-based Materials**: Access study materials tailored to your enrolled courses
- **Custom Organization**: Create folders and organize your files efficiently
- **Offline Access**: Cached files available without internet connection
- **Anywhere Access**: Study materials available across all your devices

---

## 📱 App Showcase

<div align="center">

### 🎯 **Smart Dashboard & Attendance Tracking**
*Get a complete overview of your academic progress at a glance*

<img src="screenshots/dashboard.png" alt="Dashboard" width="250"/> <img src="screenshots/attendance.png" alt="Attendance Tracking" width="250"/> <img src="screenshots/calendar.png" alt="Calendar View" width="250"/>

---

### 📚 **Course Management & Study Materials**
*Organize your courses and access study materials seamlessly*

<img src="screenshots/courses.png" alt="Course Management" width="250"/> <img src="screenshots/materials.png" alt="Study Materials" width="250"/> <img src="screenshots/notes.png" alt="Personal Notes" width="250"/>

---

### 🏆 **Gamification & Challenges**
*Make attendance fun with our engaging reward system*

<img src="screenshots/amplix.png" alt="Amplix Points" width="250"/> <img src="screenshots/challenges.png" alt="Weekly Challenges" width="250"/> <img src="screenshots/streaks.png" alt="Attendance Streaks" width="250"/>

---

### 🔔 **Smart Notifications & Settings**
*Stay informed with intelligent, customizable notifications*

<img src="screenshots/notifications.png" alt="Smart Notifications" width="250"/> <img src="screenshots/settings.png" alt="App Settings" width="250"/> <img src="screenshots/profile.png" alt="User Profile" width="250"/>

---

*📸 Screenshots are from the latest alpha build. UI may vary in the final release.*

</div>

---

## Download Attendrix

### Latest Release (Currently in Public Beta!)

<div align="center">

[![Download APK](https://img.shields.io/badge/Download-Latest%20APK-6366F1?style=for-the-badge&logo=android&logoColor=white)](https://github.com/SH1SHANK/attendrix/releases/latest/download/Attendrix_Release_v1.0.0.apk)

</div>

### Installation Steps
1. **Enable Unknown Sources**: Go to Settings > Security > Enable "Install from Unknown Sources"
2. **Download the APK**: Click the download button above or visit our [Releases](https://github.com/sh1shank/attendrix/releases) page
3. **Install**: Open the downloaded APK file and follow the installation prompts
4. **Permissions**: Grant necessary permissions for notifications, storage, and camera (for QR code scanning)

### System Requirements
- Android 6.0 (API level 23) or higher
- 100 MB free storage space
- Internet connection for sync and real-time features

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/sh1shank/attendrix.git
   cd attendrix
   ```

2. **Switch to the FlutterFlow branch**
   ```bash
   git checkout flutterflow
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Configuration
- Update the configuration files with your specific NIT Calicut slot timings
- Configure notification preferences
- Set up your academic profile

### 📁 Repository Structure
- **`main` branch**: Documentation, README, and project assets
- **`flutterflow` branch**: Complete Flutter/Dart source code

---
## 🏗️ Architecture

**Attendrix** is architected for speed, flexibility, and intelligent automation using a hybrid cloud + serverless model.

### 💻 Frontend
- **Flutter + FlutterFlow**: Cross-platform UI with custom Dart actions
- **Client-Heavy Logic**: Most features run offline with background sync

### 🧠 Backend Services
- **Supabase (PostgreSQL)** – Primary database for:
  - `timetableRecords`, `attendanceRecords`, `amplixLogs`
  - Enforced **Row-Level Security (RLS)** per user
  - **RPC Functions** and **Edge Functions** for streaks, rollback, challenge updates, analytics
- **Firestore (Selective Use)** – Stores sensitive real-time metadata (e.g., Amplix scores, session info)
- **Firebase Authentication** – Handles secure login and session management
- **Firebase Storage** – Stores study materials and static files

### 🔁 Automation & Integrations
- **BuildShip**:
  - Automates Google Calendar sync, daily CRON jobs, API key management, and Amplix workflows
- **Zapier**:
  - Parses attendance data from external tools
- **Google Cloud APIs**:
  - **Google Calendar API** *(Planned)*: Syncs class schedules with user calendars
  - **Google Drive API**: Upload, fetch, and organise shared academic resources

### 🧠 AI Integration (Planned)
- **Gemini 2.0 Flash Lite** with NotebookLLM via MCP servers for real-time LLM-based doubt resolution
- **Bring Your Own LLM**: User-supplied API keys (OpenAI, Claude, Gemini) for personalized AI support
---

## 📱 Supported Platforms

- ✅ Android
- 🔄 iOS (Coming Soon)
- ✅ Web 

---

## 🤝 Contributing

We welcome contributions from the NIT Calicut community! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

### Development Setup
1. Fork the repository
2. Clone your fork and switch to the `flutterflow` branch
3. Create a feature branch from `flutterflow`
4. Make your changes
5. Test thoroughly
6. Submit a pull request to the `flutterflow` branch

---

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Flutter and FlutterFlow communities for excellent development tools
- All beta testers and contributors who helped shape Attendrix

---

## 📞 Support

For support, feature requests, or bug reports:
- 📧 Email: [support@attendrix.site](mailto:support@attendrix.site)
- 🐛 Issues: [GitHub Issues](https://github.com/SH1SHANK/attendrix/issues/new?assignees=&labels=bug&template=bug_report.md&title=%5BBUG%5D
)
- 💡 Have an idea? [Suggest a feature!](https://github.com/SH1SHANK/attendrix/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=%5BFEATURE%5D
)
- 💬 Discussions: [GitHub Discussions](https://github.com/sh1shank/attendrix/discussions)

---

## 🔮 Future Roadmap

Attendrix is continuously evolving! Here's what's coming next:

### 🤖 **AI-Powered Doubt Resolution**
Seamless integration of **Gemini 2.0 Flash Lite API** for real-time, conversational doubt solving—leveraging MCP servers and NotebookLLM to ensure fast, context-agnostic support that avoids reliance on course-specific material, enabling broader and more adaptive learning.

### 🧠 **Intelligent Syllabus-Aware Chatbot (Bring Your Own Key)**
Allow users to link their own Google API Keys or other LLM providers (like OpenAI, Claude, or Gemini) to enable personalized assistant bots that access current syllabus documents, provide contextual answers, and clarify doubts with source-linked citations.

### 🎨 **Improved and Customizable Theming and Personalization**
Full customizable theming system with support for:
- **Dark, Light, and High-Contrast themes**
- **Accent color selection**
- **Theme presets** tied to time-of-day or focus modes (e.g., "Study Mode")

### 🏆 **Gamified Challenges System v2**
Major update to the Amplix-powered challenge system with:
- **Daily and surprise micro-challenges**
- **Leaderboards, trophies, and streak-based power-ups**
- **Integration** with class participation and attendance data

### 📅 **Calendar & Reminder Syncing (Smart Notifications)**
Two-way sync with Google Calendar, allowing:
- **Auto-import** of classes, tests, and events
- **Push reminders** based on real-time class status and attendance
- **Suggestions** for missed classes and make-up sessions

### 📱 **Offline Mode & Sync Queue**
Enable offline usage of key features like attendance logging and timetable viewing with an intelligent sync queue to push updates when back online.

### 🎯 **Custom Attendance Targets and Goals**
Set custom goals such as 90% for a class and get notified if you are below it or if you will lose that goal if you don't attend the next class.

### 📊 **Advanced Analytics**
Detailed insights into your academic performance with predictive analytics.

---

<div align="center">

**Made with 💜 for NIT Calicut Students**

*Attendrix - Making attendance management intelligent, engaging, and effortless*

[![Follow on GitHub](https://img.shields.io/github/followers/sh1shank?style=social)](https://github.com/sh1shank)
[![Star this repo](https://img.shields.io/github/stars/sh1shank/attendrix?style=social)](https://github.com/sh1shank/attendrix)

</div>
