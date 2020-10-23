#![forbid(unsafe_code)]

use tide::Result;
use postgres::{
    Client,
    NoTls,
    config::Config,
};
use r2d2::{Pool};
use r2d2_postgres::PostgresConnectionManager;

mod sha256;

/// State of the server backend.
#[derive(Clone)]
pub struct State {
    pool: Pool<PostgresConnectionManager<NoTls>>,
}

async fn signup(mut request: tide::Request<State>) -> Result<String> {
    let post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    let mut out = String::new();

    match post {
        _ => {}
    }

    Ok(out)
}

async fn log_in(mut request: tide::Request<State>) -> Result<String> {
    let post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    let mut out = String::new();

    match post {
        _ => {}
    }

    Ok(out)
}

// Called after intialization, runs the HTTP server.
async fn start(state: State) -> Result<()> {
    // Start server log
    tide::log::start();

    // Configure HTTP server endpoints (POST only)
    let mut app = tide::with_state(state);
    app.at("/signup").post(signup);
    app.at("/log_in").post(log_in);

    // Start serving HTTP server
    app.listen("192.168.0.112:8088" /*"10.0.0.90:8088"*/).await?;
    Ok(())
}

// Entry point for the program
#[async_std::main]
async fn main() -> Result<()> {
    // Grab username from the environment.
    let username = whoami::username();
    // Build Unix Domain Socket URL
    let url = format!("postgres://{:}@%2Frun%2Fpostgresql/notescout", username);
    // Make PostgreSQL configuration from URL
    let config: Config = url.parse()?;
    // Connect to the PostgreSQL database.
    let manager = PostgresConnectionManager::new(config, NoTls);
    // Build a connection pool ontop of the database.
    let pool = r2d2::Pool::new(manager).unwrap();

    // Initialize server state.
    let state = State {
        pool,
    };

    // Start the server
    start(state).await
}
