# iyam_core

`iyam_core` adalah **foundation package** untuk aplikasi Flutter yang berisi
core utilities, data layer, network layer, storage, dan database abstraction
yang **reusable, modular, dan production-ready**.

Package ini dirancang untuk:

- digunakan di banyak aplikasi
- tidak bergantung pada UI
- mudah dikustom dari aplikasi (inversion of control)
- cocok untuk small hingga enterprise-scale app

---

## ✨ Features

### 🔌 Network

- Dio initializer
- Auth & refresh token interceptor
- API request/response logging
- Offline queue & retry
- Unified network & repository result

### 🗄️ Data Layer

- Base Repository & DataSource
- Offline-first repository template
- Pagination abstraction
- List response & meta handling

### 💾 Storage

- Secure storage wrapper
- Local storage (SharedPreferences)
- Generic read/write list helpers

### 🗃️ Database

- Sqflite database initializer
- Base DAO abstraction
- TTL cache helper
- Optional encrypted database
- Optional Drift ORM support

### 🧰 Utilities

- Logger (debug, info, warning, error)
- Date formatter
- Validators
- Network checker

---

## 📦 Installation

### Public (pub.dev)

```yaml
dependencies:
  iyam_core: ^0.1.0
```
