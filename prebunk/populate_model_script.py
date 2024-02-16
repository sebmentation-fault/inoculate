"""
This file is intended to be run when the server is started for the first time, and the database is empty.
It will populate the database with the necessary data (extracted from a CSV file) such that there is a range of option
selections, disinformation tactics, and tactic explanations.
"""

import csv
import os
from random import sample


def read_dataset(file_path: str) -> [dict]:
    """
    Reads the dataset from the CSV file which is in the following format:

    title | news url | is accurate flag
    """
    pass


def main():
    pass


if __name__ == '__main__':
    main()
