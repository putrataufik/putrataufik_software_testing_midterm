# putrataufik_software_testing_midterm

A new Flutter project.

## Overview
Ini merupakan aplikasi Flutter sederhana yang menerapkan arsitektur MVVM (Model-View-ViewModel) dan unit testing menggunakan flutter_test serta mockito. Aplikasi ini terintegrasi dengan API autentikasi dari dummyjson.com untuk melakukan proses login, mendapatkan token, dan mengambil data pengguna.

## Features
- Username and password validation
- Login/logout logic in ViewModel
- Unit testing with mocking
- Boundary and negative test cases

## Test Cases

| TC ID            | Description                           | Status |
|------------------|---------------------------------------|--------|
| TC_AUTH_VM_001   | Validate Empty Username               | ✅     |
| TC_AUTH_VM_002   | Validate Short Password               | ✅     |
| TC_AUTH_VM_003   | Successful Login                      | ✅     |
| TC_AUTH_VM_004   | Login with Invalid Credentials        | ✅     |
| TC_AUTH_VM_005   | Logout Functionality                  | ✅     |
| TC_AUTH_VM_006   | Username Length Boundary Values       | ✅     |
| TC_AUTH_VM_007   | Password Length Boundary Values       | ✅     |
| TC_AUTH_VM_008   | Login with Special Characters         | ✅     |
| TC_AUTH_VM_009   | Login with SQL Injection Attempt      | ✅     |
| TC_AUTH_VM_010   | Login with Empty Fields               | ✅     |

![Screenshot 2025-05-22 104923](https://github.com/user-attachments/assets/4e874971-b46a-46bc-960f-05416ab71615)



## How to Run
1. **Clone this repo**
2. Run:
   flutter pub get
   flutter test
   flutter run
   
## Use the following test credentials (from DummyJSON API):
- Username: emilys
- Password: emilyspass
