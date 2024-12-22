import time
from subprocess import Popen, PIPE
from pexpect import spawn, exceptions, EOF, TIMEOUT


def run_command(command):
    process = Popen(command, shell=True, stdout=PIPE, stderr=PIPE)
    process.wait()
    return process


def run_command_with_passphrase(
    command, passphrase, confirm_passphrase=False, incorrect_passphrase=False
):
    child = spawn(command=command, encoding="utf-8")
    pass_confirm = "some_random_passphrase" if incorrect_passphrase else passphrase
    try:
        index = child.expect([r"Passphrase:", EOF, TIMEOUT], timeout=10)
        if index == 0:
            child.sendline(passphrase)
            if confirm_passphrase:
                child.sendline(pass_confirm)
                child.expect([EOF, TIMEOUT])
        return child
    except exceptions.ExceptionPexpect as e:
        print(f"Error executing command: {e}")
