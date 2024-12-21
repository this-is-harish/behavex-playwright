import utils.terminal_helper as terminal_helper
from behave import step

@step('user executes command to retrieve keys with "{passphrase_condition}" passphrase for "{user_condition}" user')
def execute_command(context, passphrase_condition, user_condition):
    context.user_name = context.user_name+"invalid" if user_condition == "invalid" else context.user_name
    passphrase = "random_pass_phrase" if passphrase_condition == 'incorrect' else context.passphrase
    command = f"{context.nunet_path} key did {context.user_name}"
    context.keys= terminal_helper.run_command_with_passphrase(command=command,passphrase=passphrase).read()

@step('keys for the specific user {condition} retrieved')
def verify_keys(context, condition: str):
    if condition.startswith('is not'):
        assert str(context.keys).__contains__("Error: failed to get key: failed to unmarshal keystore file: mac mismatch"), context.keys
    else:
        assert str(context.keys).__contains__("did:key"), context.keys

@step('key not found error message is displayed')
def verify_key_not_found(context):
    assert context.keys.__contains__("Error: failed to get key: key not found on this node"), context.keys