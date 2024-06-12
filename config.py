import os
from dotenv import load_dotenv

load_dotenv()
PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))

global CONFIG
CONFIG = {
    'URL': f"https://{os.environ.get('URL')}",
    'USER':os.environ.get('USER_NAME'),
    'PASSWORD':os.environ.get('PASSWORD')
}