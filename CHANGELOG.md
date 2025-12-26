# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/).

---

## [0.1.0] - 2025-01-14

### Added

- Initial release of `iyam_core`
- Network layer:
  - Dio initializer
  - Auth & refresh token interceptor
  - API request/response logging
  - Offline queue & retry mechanism
- Data layer:
  - Base repository & datasource abstraction
  - Offline-first repository template
  - Pagination abstraction
  - List response & meta handling
- Storage:
  - Secure storage wrapper
  - Local storage wrapper
  - Generic read/write list helpers
- Database:
  - Sqflite database initializer
  - Base DAO abstraction
  - TTL cache helper
  - Optional encrypted database support
  - Optional Drift ORM integration
- Utilities:
  - Logger
  - Date formatter
  - Validators
  - Network checker
- App configuration:
  - Environment & AppConfig abstraction

---
