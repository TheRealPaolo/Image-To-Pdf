# Flutter Image to PDF Converter

A straightforward utility application built with Flutter to select images from a device gallery and compile them into a single PDF document. The application handles file picking, in-memory image conversion, document compilation to standard A4 layout, and system storage write operations.

---

## Technical Overview & Architecture

The workflow of the application separates asset selection, document compiling, and system saving operations:

*   **UI Framework:** [Flutter](https://flutter.dev) (Material Design).
*   **Asset Picker:** Uses the `image_picker` package to safely access the host device's local media library.
*   **Document Generation:** Leverages the `pdf` package to construct PDF file structures, render pages, and place images into native PDF canvas formats.
*   **Storage Access:** Utilizes the `path_provider` package to resolve system-approved application storage directories for writing target documents.
*   **Notification Engine:** Employs `another_flushbar` to provide visual task completion states (success/failure) directly to the interface.

---

## Key Features

- **Multi-Image Collection Queue:** Add multiple images sequentially from the native photo gallery.
- **On-Demand PDF Compilation:** One-click compiling flow converting stacked images to an integrated PDF document.
- **Standard A4 Layout Rendering:** Automatic center-alignment of imported memory images onto standard A4 dimension PDF pages.
- **Visual Queue Preview:** Dynamic grid/list view allowing developers and users to check picked files before writing the final PDF file to disk.

---

## Dependencies

Specify these packages within your project's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.7
  pdf: ^3.10.7
  path_provider: ^2.1.2
  another_flushbar: ^1.12.30
```

---

## Platform-Specific Configurations

### Android
For standard file system operations, ensure the following permissions are present in your `android/app/src/main/AndroidManifest.xml` (depending on API level requirements):

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="29" />
```

### iOS
For image selection, declare description keys inside your `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>This app requires access to the photo library to select images for PDF conversion.</string>
```

---

## Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/image-to-pdf-converter.git
    cd image-to-pdf-converter
    ```

2.  **Pull required package dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the application on an attached physical device or simulator:**
    ```bash
    flutter run
    ```

---

## PDF Construction Reference

The PDF conversion logic parses local disk files to memory bytes, building target page structures on an standard format:

```dart
// Simplified operational block from the codebase
create() async {
  for (var img in _image) {
    final image = pw.MemoryImage(img.readAsBytesSync());

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Image(image));
        }));
  }
}
```

---

## Badges

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Platform-Flutter-blue.svg)](https://flutter.dev)

---

## Feedback & Contributions

To report bugs, submit performance updates, or suggest implementation enhancements, open a ticket on the project's repository.
