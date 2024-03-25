# Prebunk - The Backend

## Datasets

Currently the system uses the following 4 datasets: 

* `./datasets/causality_mock_data.csv` - contains information about causality
* `./datasets/selection_bias_mock_data.csv` - contains information that may have selection biases
* `./datasets/emotive_mock_data.csv` - contains information that may use emotive language
* `./datasets/numbers_nonesense_mock_data.csv` - contains information that may use nonsense numbers

> ⚠ Due to time constraints, a LLM was used to synthetically generate the content, and has manually been scanned over. A more long term solution, built for public use should probably come up with content designed by experts.

The columns are separated using the 'pipe' character, and have the following columns:

* information (string)
* source (string)
* correct option (accurate/fake) 
* incorrect option (accurate/fake)
* display not sure (boolean)
* feedback (string)

## Configuration

### 1. Generate a New Key

Every new machine needs to set up a `SECRET_KEY` as an environment variable, so that `prebunk/settings.py` can access it.

Enter the `django` shell:
```shell
python manage.py shell
```

Generate a secure key in this shell:
```python
> from django.core.management.utils import get_random_secret_key
> get_random_secret_key()
your_secret_key
```

### 2. Set Up the Environment Variables

You will need to set up some environment variables. These are not tracked by the `git` repository, so are custom to you.

Add the following to a `.env` file. 

#### 2.1. The Secret Key

```env
DJANGO_SECRET_KEY='your_secret_key'
```

#### 2.1. Debugging output

Set up debugging on your local testing machine by setting this to `True`:
```env
DJANGO_DEBUG=True
```

### 3. Installing dependencies

Since `prebunk` uses *Python*, the packages can be installed using `pip`. Simply run:
```shell
$ pip install -r requirements.txt
```

#### 3.1. Virtual Environment

It is common practise in python projects to install them to a virtual environment (`venv`). To use a `venv`, you will have to `activate` it in your shell every time you attempt to compile. It will also need to be activated when installing the dependencies. 

### Virtual Private Server

The VPS is currently hosted *DigitalOcean*, and has already been set-up already in a similar way as seen in step 1 and 2.

## Compilation

Before running a server, you need to ensure that the *Django* project is migrated and the database is synced up to any changes to the models.

To create a new migration (important if there have been any changes to the models), run:
```python
python manage.py makemigrations
```

To sync the database to these new changes (also used if a new migration has been pulled from the remote):
```python
python manage.py migrate 
```

### Development

To spin up a server in development mode or onto `localhost`, you will need to use the following command:
```python
python manage.py runserver
```

### Production - The Virtual Private Server

Changes can be deployed to the VPS by merging to the `main` branch. Doing so should work for most changes, as it activates a CI/CD pipeline. The pipeline synchronizes changes to the codebase to the VPS, migrates any changes to the Django models, and then restarts the *Gunicorn* instance.

Manual changes the server are not recommended, but might be necessary if a change is needed that does not get managed by the pipeline.

