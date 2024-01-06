# Prebunk - The Backend

## Configuration

### 1. Generate a New Key

Every new machine needs to set up a `SECRET_KEY` as an enviroment variable, so that `prebunk/settings.py` can access it.

Enter the `django` shell:
```shell
$ python manage.py shell
```

Generate a secure key:
```python
from django.core.management.utils import get_random_secret_key

get_random_secret_key()
```

### 2. Set Up an Enviroment Variable

In `.zshenv` add the line (MacOS X/Linux):
```shell
export DJANGO_SECRET_KEY='secret_key_from_earlier'
```

### 3. Optional

Set up debugging on your local testing machine:
```shell
export DJANGO_DEBUG=True
```
