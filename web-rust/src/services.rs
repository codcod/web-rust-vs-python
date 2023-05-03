use crate::AppState;
pub(crate) use actix_web::{
    get, post,
    web::{Data, Json, Path},
    HttpResponse, Responder,
};
use chrono::NaiveDate;
use serde::{Deserialize, Serialize};
use sqlx::{self, FromRow};

#[derive(Serialize, FromRow)]
struct Author {
    author_id: i32,
    first_name: String,
    last_name: String,
}

#[derive(Serialize, FromRow)]
struct Book {
    book_id: i32,
    title: String,
    summary: String,
    publication_date: NaiveDate,
    author_id: i32,
}

#[derive(Deserialize, Debug)]
pub struct CreateBookBody {
    pub title: String,
    pub summary: String,
    pub publication_date: NaiveDate,
}

#[get("/authors")]
pub async fn fetch_authors(state: Data<AppState>) -> impl Responder {
    match sqlx::query_as::<_, Author>("SELECT author_id, first_name, last_name FROM authors")
        .fetch_all(&state.db)
        .await
    {
        Ok(authors) => HttpResponse::Ok().json(authors),
        Err(_) => HttpResponse::NotFound().json("No authors found"),
    }
}

#[get("/authors/{id}/books")]
pub async fn fetch_authors_books(state: Data<AppState>, path: Path<i32>) -> impl Responder {
    let id: i32 = path.into_inner();

    match sqlx::query_as::<_, Book>(
        "SELECT book_id, title, summary, publication_date, author_id FROM books WHERE author_id = $1",
    )
    .bind(id)
    .fetch_all(&state.db)
    .await
    {
        Ok(books) => HttpResponse::Ok().json(books),
        Err(_) => HttpResponse::NotFound().json("No books found"),
    }
}

#[post("/authors/{id}/books")]
pub async fn create_author_book(
    state: Data<AppState>,
    path: Path<i32>,
    body: Json<CreateBookBody>,
) -> impl Responder {
    let id: i32 = path.into_inner();

    match sqlx::query_as::<_, Book>(
        "INSERT INTO books (title, summary, publication_date, author_id) VALUES ($1, $2, $3, $4)
        RETURNING book_id, title, summary, publication_date, author_id",
    )
    .bind(body.title.to_string())
    .bind(body.summary.to_string())
    .bind(body.publication_date)
    .bind(id)
    .fetch_one(&state.db)
    .await
    {
        Ok(book) => HttpResponse::Ok().json(book),
        Err(_) => HttpResponse::InternalServerError().json("Failed to create a book for an author"),
        //Err(error) => panic!("error: {}", error),
    }
}

// vim: sw=4:et:ai
