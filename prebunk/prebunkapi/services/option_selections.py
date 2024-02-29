from prebunkapi.models.modles import OptionSelectionModel


def list_options(tactic_id: int) -> [OptionSelectionModel]:
    """
    List all options for a given disinformation tactic.

    Args:
        tactic_id (int): Primary key of the disinformation tactic.

    Returns:
        list: List of OptionSelection instances.
    """
    pass


def create_option() -> OptionSelectionModel:
    """
    Create a new option.

    Args:

    Returns:
        OptionSelectionModel: Created OptionSelection instance.
    """
    pass
