# Prebunk - The Backend

## Configuration

### 1. Generate a New Key

Every new machine needs to set up a `SECRET_KEY` as an environment variable, so that `prebunk/settings.py` can access it.

Enter the `django` shell:
```shell
python manage.py shell
```

Generate a secure key:
```python
from django.core.management.utils import get_random_secret_key

get_random_secret_key()
```

### 2. Set Up the Environment Variables

You will need to set up some environment variables. These are not tracked by the `git` repository, so are custom to you.

Add the following to a `.env` file. 

#### 2.1. The Secret Key

```python
DJANGO_SECRET_KEY='secret_key_from_step_1'
```

#### 2.1. Debugging output

Set up debugging on your local testing machine by setting this to `True`:
```python
DJANGO_DEBUG=True
```
