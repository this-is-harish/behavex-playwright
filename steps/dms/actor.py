import utils.terminal_helper as terminal_helper
from behave import step
import names
from pathlib import Path


@step("DMS is installed")
def dms_installed(context):
    assert terminal_helper.run_command(command=context.nunet_path).returncode == 0


@step(
    'user executes command to create new {user_condition} with "{passphrase_condition}" passphrase'
)
def create_new_user(context, user_condition: str, passphrase_condition: str):
    incorrect_passphrase = True if passphrase_condition == "incorrect" else False
    context.user_name = names.get_first_name().lower() + names.get_last_name().lower()
    if user_condition.startswith("invalid"):
        context.user_name = names.get_last_name().lower() + "@!#$%^&()"
    command = f"{context.nunet_path} cap new {context.user_name}"
    terminal_helper.run_command_with_passphrase(
        command=command,
        passphrase=context.passphrase,
        confirm_passphrase=True,
        incorrect_passphrase=incorrect_passphrase,
    )


@step("new {dms_or_user} {condition} created")
def verify_new_user(context, dms_or_user: str, condition: str):
    file_path = Path(f"~/.nunet/cap/{context.user_name}.cap").expanduser()
    expected = file_path.is_file()
    if condition == "is not":
        assert expected == False, f"File exists: {file_path}"
    else:
        assert expected == True, f"File does not exist: {file_path}"
