import os

from dotenv import load_dotenv
from playwright.sync_api import sync_playwright, Page
from behave.runner import Context

from config import CONFIG
from utils.terminal_helper import run_command

load_dotenv()


def before_scenario(context: Context, scenario):
    print(f"{scenario}--> Starting")


def before_all(context):
    context.passphrase = os.getenv("PASSPHRASE")
    context.nunet_path = "/usr/local/bin/dms_darwin_arm64"
