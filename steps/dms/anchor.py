import utils.terminal_helper as terminal_helper
from behave import step


@step("user adds specific user to root dms context with {key_condition} key")
def execute_command(context, key_condition: str):
    context.keys = (
        context.keys + "random" if key_condition.startswith("invalid") else context.keys
    )
    command = f"{context.nunet_path} cap anchor --context dms --root {context.keys}"
    context.anchor_output = terminal_helper.run_command_with_passphrase(
        command=command, passphrase=context.passphrase
    )


@step("specified user {is_or_is_not} added root anchor")
def verify_anchoring(context, is_or_is_not):
    if is_or_is_not == "is not":
        assert context.anchor_output.wait() != 0, context.anchor_output.wait()
    else:
        assert context.anchor_output.wait() == 0, context.anchor_output.wait()


@step("user creates grant user context for {condition} expiry date")
def grant_user_context(context, condition: str):
    expiry_date = "2024-12-31" if condition == "valid" else "2023-13-31"
    command = f"{context.nunet_path} cap grant --context user --cap /public --cap /broadcast --topic /nunet --expiry {expiry_date} {context.keys}"
    context.grant_output = terminal_helper.run_command_with_passphrase(
        command=command, passphrase=context.passphrase
    )


@step("user {is_or_is_not} granted access successfully")
def grant_access_success(context, is_or_is_not):
    if is_or_is_not == "is not":
        assert (
            context.grant_output.wait() != 0
        ), f"Expected 1 but got {context.grant_output.wait()}"
    else:
        assert (
            context.grant_output.wait() == 0
        ), f"Expected 0 but got {context.grant_output.wait()}"


@step("user revokes access from non-existent context")
def revoke_access_from_non_existent_context(context):
    command = f"{context.nunet_path} cap --context non-existent revoke"
    context.anchor_output = terminal_helper.run_command_with_passphrase(
        command=command, passphrase=context.passphrase
    )


@step("command returns code 0")
def return_code_0(context):
    assert (
        context.anchor_output.wait() == 0
    ), f"Expected 0 but got {context.anchor_output.wait()}"
