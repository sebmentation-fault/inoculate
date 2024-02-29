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

### Development

During development, I find it more accessible to test using the web app of the app, but doing so requires dropping some security privaliges, so I use the following command:

```shell
flutter run -d chrome --web-browser-flag "--disable-web-security"
```
