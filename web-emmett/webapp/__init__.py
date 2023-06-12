__version__ = '0.1.0'

from emmett import App
from emmett.orm import Database, Model, Field, has_many, belongs_to

app = App(__name__)
app.config.db.uri = 'postgres+asyncpg://postgres:postgres@localhost:5432/postgres'

class Author(Model):
    author_id = Field(type='id')
    first_name = Field()
    last_name = Field()
    has_many('books')

class Book(Model):
    book_id = Field(type='id')
    title = Field()
    summary = Field()
    publication_date = Field().datetime()
    belongs_to('Author')


db = Database(app, pool_size=20)
db.define_models(Author, Book)

app.pipeline = [db.pipe]

from . import views

# vim: sw=4:et:ai
