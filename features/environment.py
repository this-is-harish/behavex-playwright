from dotenv import load_dotenv
from playwright.sync_api import sync_playwright, Page
from behave.runner import Context

from config import CONFIG

load_dotenv()
def before_scenario(context: Context, scenario):
    print(f"{scenario}--> Starting")
    playwright = sync_playwright().start()
    browser = playwright.chromium.launch(args=["--start-maximized"],headless=False)
    browser_context = browser.new_context(ignore_https_errors=True,record_video_dir=context.evidence_path,no_viewport=True)
    browser_context.set_default_timeout(20000)
    context.page = browser_context.new_page()
    context.page.goto(context.url)
    context.browser = browser
    context.playwright = playwright
    if 'Invalid' in context.tags:
        context.user_name = 'YOUR_OWN_VALUE'

def before_all(context: Context):
    context.url = CONFIG['URL']
    context.user_name = CONFIG['USER']
    context.password = CONFIG['PASSWORD']

def after_step(context: Context,step):
    page: Page = context.page
    page.wait_for_load_state()
    page.screenshot(path=f"{context.evidence_path}/{step.name[:50].replace(' ','_')}")