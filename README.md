1. Code Documentation
Overview:

This application is an E-Book Reader built with Flutter. It supports features such as viewing EPUB books, uploading new books, and providing a theme switcher for light and dark modes. The application uses GetX for state management.

Main Components:

HomePage: Displays the main page with a list of books and the bottom navigation bar.
BookController: Manages the logic for uploading books and interacting with the file system.
ThemeController: Controls the theme switch (light/dark mode).
BookDetailPage: Shows detailed information about a book when it is selected.
EpubViewerPage: Allows viewing of EPUB files.
UploadProgressWidget: Displays the upload progress for books.
FilePreviewWidget: Shows a preview of the uploaded file.
Code Structure:

main.dart: Entry point of the application.
pages/: Contains UI pages like HomePage, BookDetailPage, etc.
controllers/: Contains the logic for managing books and theme.
widgets/: Custom widgets like file previews and upload progress.
models/: Contains any models like Book, User, etc.

2. API Documentation
Overview:

The application relies on multiple backend services to fetch and manage book data. The API endpoints used for this application are as follows:

Endpoints:
GET /books
Retrieves a list of books from the server.
Response Example:

json
Copy
Edit
[
  {
    "id": 1,
    "title": "Book Title 1",
    "author": "Author 1",
    "description": "Book Description",
    "epub_url": "/assets/epub/book1.epub"
  },
  {
    "id": 2,
    "title": "Book Title 2",
    "author": "Author 2",
    "description": "Book Description",
    "epub_url": "/assets/epub/book2.epub"
  }
]
POST /upload
Uploads a new book to the server.
Body Parameters:

file: The file to be uploaded.
title: Title of the book.
author: Author of the book.
description: Short description of the book.
Response Example:

json
Copy
Edit
{
  "status": "success",
  "message": "Book uploaded successfully!"
}
Authentication:
The API uses JWT (JSON Web Tokens) for authentication. The client must send a Authorization header with the token.
3. User Manual
Introduction:

The E-Book Reader allows users to read e-books, manage their personal library, and customize the theme (light or dark mode).

Features:

View a list of available books.
Upload new books to the library.
View EPUB books.
Toggle between light and dark themes.
How to Use:
Navigating the App:

On the bottom navigation bar, you can switch between the Home, Books, and Settings pages.
On the Home page, you will see the available books. Tap on any book to view its details.
On the Books page, you can view more information about your collection of books.
On the Settings page, you can adjust the app's theme (light or dark mode).
Uploading a Book:

Tap the floating action button (with an upload icon) to upload a new book.
Select a file from your device to upload. Once the upload is complete, the book will appear in the list.
Reading EPUB Books:

Tap on any EPUB book listed in the Home page to open it in the EPUB viewer.
Changing the Theme:

The theme can be switched between light and dark mode via the toggle in the app bar.
4. Installation Guide
Prerequisites:
Ensure that you have Flutter installed on your system.
You should have Android Studio or VS Code installed for development.
Steps to Install:
Clone the Repository:

bash
Copy
Edit
git clone https://github.com/your-repository/e-book-reader.git
Install Dependencies: Navigate to the project directory and run:

bash
Copy
Edit
flutter pub get
Run the App: You can run the app on an emulator or a connected device using:

bash
Copy
Edit
flutter run
Build the APK (Optional): If you want to create an APK to install on a physical device, use:

bash
Copy
Edit
flutter build apk
Deploy to Device:

Connect an Android/iOS device.
Ensure your device is recognized by running:
bash
Copy
Edit
flutter devices
Run the app on your device with:
bash
Copy
Edit
flutter run
Conclusion
This documentation provides an overview of the app’s structure, its API endpoints, instructions for usage, and how to set up the development environment. This should give a comprehensive guide for developers and end-users alike.
