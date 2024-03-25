# `inoculate` - The Frontend

A Fake News Inoculation Game

## Configuration

### 1. Set Up the Enviroment Variables

You will need to set up some enviroment variables. These are not tracked by the `git` repository, so are custom to you.

Add the following to a `.env` file. 

#### 2.1. The Firebase Key

Go to the firebase console and download the admin key, and store the `json` file in a secure location.

```shell
GOOGLE_APPLICATION_CREDENTIALS='/the_absolute_path_dir/firebase-admin-key.json'
```

## Compilation

To compile the flutter project, you might need to sort out some dependencies first.

### Prerequisites

* `flutter` SDK - [Flutter SDK installation guide](https://docs.flutter.dev/get-started/install)
    > ⚠  Note: different platforms might have slightly different installation guides 
* `firebase` CLI - [Firebase CLI installation guide](https://firebase.google.com/docs/flutter/setup?platform=android)

### Development

During development, I find it more accessible to test using the web app, but doing so requires dropping some security privaliges, so I use the following command:

```shell
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

> ⚠  Note: When compiling to Android/iOS, these security flags do not need to be used, as the mobile apps aren't prone to XSS attacks.

> ⚠  Note: The frontend is automatically attempts to send API calls to `localhost` when debug mode is active. If you want to test the system in debug mode, using the backend, then you will need to modify the [API constants file](./lib/constants/api_constants.dart) (not recommended).

### Production

For production, compile to *iOS* or *Android* respectively.

> ⚠  Note: The frontend is automatically attempts to send API calls to the backend when built as a binary. If you want to test the binary using `localhost`, then you will need to modify the [API constants file](./lib/constants/api_constants.dart).
