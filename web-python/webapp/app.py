"""
Main app.
"""

from aiohttp import web

from . import db
from .logging import get_logger
from .settings import BASE_DIR, load_config
from .views import routes

logger = get_logger(__name__)


async def setup_app(app: web.Application) -> None:
    config = load_config('config/config.toml')
    engine = await db.get_engine()

    app['config'] = config
    app['engine'] = engine


async def teardown_app(app: web.Application) -> None:
    engine = app['engine']
    await engine.dispose()


async def make_app() -> web.Application:
    app = web.Application()
    app.on_startup.append(setup_app)
    app.on_cleanup.append(teardown_app)
    app.add_routes(routes)
    return app
