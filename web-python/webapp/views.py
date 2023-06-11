"""
Views.
"""

import datetime
import os

from aiohttp import web
from aiohttp.web_request import Request
from aiohttp.web_response import Response

from . import queries
from .json import dumps, jsonify_rows
from .logging import get_logger

logger = get_logger(__name__)

routes = web.RouteTableDef()


@routes.get('/')
async def index(req: Request) -> Response:
    logger.debug('Index page requested')
    return web.json_response(dict(os.environ))


@routes.get('/author/{id:\d+}')
async def fetch_author(req: Request) -> Response:
    id = req.match_info['id']
    engine = req.app['engine']

    async with engine.begin() as conn:
        record = await queries.fetch_author(conn, int(id))

    return web.json_response({'row': jsonify_rows(record)}, dumps=dumps)


@routes.get('/authors')
async def fetch_authors(req: Request) -> Response:
    engine = req.app['engine']

    async with engine.begin() as conn:
        records = await queries.fetch_authors(conn)

    return web.json_response({'rows': jsonify_rows(records)}, dumps=dumps)


@routes.post('/authors/{id:\d+}/books')
async def save_book(req: Request) -> Response:
    id = req.match_info['id']
    engine = req.app['engine']

    data = await req.json()
    pub_date = datetime.date.fromisoformat(data['publication_date'])

    async with engine.begin() as conn:
        records = await queries.save_book(
            conn,
            title=data['title'],
            summary=data['summary'],
            publication_date=pub_date,
            author_id=int(id),
        )

    return web.json_response({'records': jsonify_rows(records)}, dumps=dumps)
