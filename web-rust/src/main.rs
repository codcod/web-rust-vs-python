pub(crate) use actix_web::{web::Data, App, HttpServer};
use dotenv::dotenv;
use sqlx::{postgres::PgPoolOptions, Pool, Postgres};

mod services;
use services::{create_author_book, fetch_authors, fetch_authors_books};

pub struct AppState {
    db: Pool<Postgres>,
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenv().ok();
    let database_url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    let max_connections = std::env::var("MAX_CONNECTIONS").expect("MAX_CONNECTIONS must be set");
    let pool = PgPoolOptions::new()
        .max_connections((&max_connections).parse::<u32>().unwrap())
        .connect(&database_url)
        .await
        .expect("Error building a connection pool");

    HttpServer::new(move || {
        App::new()
            .app_data(Data::new(AppState { db: pool.clone() }))
            .service(fetch_authors)
            .service(fetch_authors_books)
            .service(create_author_book)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}

// vim: sw=4:et:ai
