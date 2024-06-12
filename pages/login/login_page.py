from playwright.sync_api import Page

class LoginPage:
    def __init__(self, context):
        page: Page = context.page
        self.user_name_text_box = page.locator(selector='input[name="email"]')
        self.password_text_box = page.locator(selector='input[name="pass"]')
        self.login_button = page.locator(selector='button[name="login"]')
        self.error_login_message = page.locator(selector='div[id="email_container"]')

    def fill_user_name(self, user_name):
        self.user_name_text_box.fill(user_name)

    def fill_password(self, password):
        self.password_text_box.fill(password)

    def click_login_button(self):
        self.login_button.click()