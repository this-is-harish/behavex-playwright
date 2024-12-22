import os

from behave import step
import utils.terminal_helper as terminal_helper


@step("user enters command to run dms with {passphrase_condition} passphrase")
def nunet_run(context, passphrase_condition):
    os.environ["DMS_PASSPHRASE"] = "hello"
    command = f"{context.nunet_path} run > /dev/null 2>&1 &"
    terminal_helper.run_command(command=command)


@step("dms is running on port 9999")
def dms_is_running(context):
    import time

    time.sleep(3)
    command = "lsof -i:9999"
    output = str(terminal_helper.run_command(command=command).stdout.read())
    terminal_helper.run_command("kill -9 $(lsof -t -i:9999)")
    assert "dms_darwi" in output


@step("port 9999 is already running")
def port_is_already_running(context):
    import http.server

    http.server.test(
        HandlerClass=http.server.SimpleHTTPRequestHandler, Port=9999, bind="127.0.0.1"
    )
