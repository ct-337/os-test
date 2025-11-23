from flask import Flask, jsonify
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import os

app = Flask(__name__)

def get_browser():
    chrome_options = Options()
    chrome_options.add_argument('--headless')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('--disable-dev-shm-usage')
    driver = webdriver.Chrome(options=chrome_options)
    return driver

@app.route('/')
def home():
    return "Browser service running"

@app.route('/browse/<path:url>')
def browse(url):
    driver = get_browser()
    driver.get(f'https://{url}')
    title = driver.title
    html = driver.page_source
    driver.quit()
    return jsonify({'title': title, 'html': html[:500]})

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 10000))
    app.run(host='0.0.0.0', port=port)
