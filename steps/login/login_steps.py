from behave import step
from behave.runner import Context
from playwright.sync_api import expect

from pages.login.login_page import LoginPage


@step('User enters login details')
def do_this(context: Context):
    login_page = LoginPage(context)
    login_page.fill_user_name(user_name=context.user_name)
    login_page.fill_password(password=context.password)


@step('User clicks submit button')
def click_submit_button(context: Context):
    login_page = LoginPage(context)
    login_page.click_login_button()


@step('Following error message is displayed: "{error_msg}"')
def validate_error_message(context: Context, error_msg):
    login_page = LoginPage(context)
    expect(login_page.error_login_message).to_contain_text(error_msg)
