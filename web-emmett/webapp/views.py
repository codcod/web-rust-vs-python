from emmett import request
from emmett.tools import service

from . import app, db
from . import Author


@app.route("/")
@service.json
async def index():
    return dict(status="OK")

@app.route('/authors')
@service.json
async def authors():
    authors = db(Author).select()
    return dict(authors=authors)

@app.route('/author/<int:id>')
@service.json
async def author():
    author = db(Author.author_id == id).select()
    return dict(author=author)

@app.route('/authors/<int:id>/books', methods='post')
@service.json
async def save_book(id):
    data = await request.body_params
    book = db.Book.insert(
        title=data['title'],
        summary=data['summary'],
        publication_date=data['publication_date']
    )
    return dict(book_id=book)
