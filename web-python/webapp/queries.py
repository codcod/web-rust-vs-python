"""
DB queries.
"""

from sqlalchemy.ext.asyncio import AsyncConnection
from sqlalchemy.sql import insert, select

from .db import metadata


async def fetch_authors(conn: AsyncConnection):
    authors = metadata.tables['authors']
    records = await conn.execute(select(authors))
    return records


async def fetch_author(conn: AsyncConnection, id: int):
    authors = metadata.tables['authors']

    stmt = select(authors).where(authors.c.author_id == id)
    records = await conn.execute(stmt)
    return records


async def save_book(
    conn: AsyncConnection, title, summary, publication_date, author_id: int
):
    books = metadata.tables['books']

    stmt = insert(books).values(
        title=title,
        summary=summary,
        publication_date=publication_date,
        author_id=author_id,
    )

    # won't return any rows
    # https://docs.sqlalchemy.org/en/20/tutorial/data_insert.html#executing-the-statement
    records = await conn.execute(stmt)
    return records.inserted_primary_key_rows
