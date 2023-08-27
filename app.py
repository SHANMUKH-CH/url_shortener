from flask import Flask, request, redirect, render_template, g
import random
import string
import sqlite3

app = Flask(__name__)
app.config['DATABASE'] = 'url_shortener.db'

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(app.config['DATABASE'])
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def generate_short_url():
    characters = string.ascii_letters + string.digits
    return ''.join(random.choice(characters) for _ in range(6))

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        long_url = request.form.get('url')
        if not long_url:
            return 'Invalid URL', 400

        db = get_db()

        # Check if the long URL already exists in the database
        existing_row = db.execute('SELECT short_url FROM urls WHERE long_url = ?', (long_url,)).fetchone()
        if existing_row:
            existing_short_url = existing_row[0]
            return render_template('index.html', short_url=request.url_root + existing_short_url, already_shortened=True)

        short_url = generate_short_url()

        # Insert the short URL and long URL into the database
        db.execute('INSERT INTO urls (short_url, long_url) VALUES (?, ?)', (short_url, long_url))
        db.commit()

        return render_template('index.html', short_url=request.url_root + short_url, already_shortened=False)

    return render_template('index.html', short_url=None)

@app.route('/<short_url>')
def redirect_to_long_url(short_url):
    db = get_db()
    result = db.execute('SELECT long_url FROM urls WHERE short_url = ?', (short_url,)).fetchone()

    if result:
        long_url = result[0]
        return redirect(long_url, code=302)
    else:
        return 'URL not found', 404

if __name__ == '__main__':
    init_db()
    # app.debug = True
    app.run(host='0.0.0.0', port=5000)
