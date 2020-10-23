#![forbid(unsafe_code)]

use postgres::{config::Config, fallible_iterator::FallibleIterator, Client, NoTls};
use r2d2::Pool;
use r2d2_postgres::PostgresConnectionManager;
use tide::Result;

mod sha256;

/// State of the server backend.
#[derive(Clone)]
pub struct State {
    pool: Pool<PostgresConnectionManager<NoTls>>,
}

/// Called when the user posts to /signup
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

/// Called when the user posts to /log_in
///
/// - MALFORM: Post Request Is Malformed
/// - SUCCESS: Log In Succeeded
/// - INVALID: Invalid Username Password Combination
/// - MISSING: User is Missing From Database
/// - FAILURE: Failed to connect to databsse
async fn log_in(mut request: tide::Request<State>) -> Result<String> {
    let post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    let mut out = String::new();
    let mut lines = post.lines();

    // Test if username is in the database
    // FIXME: Separate into it's own function
    let username = if let Some(username) = lines.next() {
        if let Ok(mut connection) = request.state().pool.get() {
            if let Ok(mut trans) = connection.transaction() {
                if let Ok(stmt) = trans.prepare(&format!("SELECT ")) {
                    if let Ok(portal) = trans.bind(&stmt, &[]) {
                        if let Ok(mut rows) = trans.query_portal_raw(&portal, 50) {
                            while let Some(row) = if let Ok(row) = rows.next() {
                                row
                            } else {
                                return Ok("FAILURE".to_string());
                            } {
                                dbg!(row);
                            }
                            username
                        } else {
                            return Ok("FAILURE".to_string());
                        }
                    } else {
                        return Ok("FAILURE".to_string());
                    }
                } else {
                    return Ok("FAILURE".to_string());
                }
            } else {
                return Ok("FAILURE".to_string());
            }
        } else {
            return Ok("FAILURE".to_string());
        }
    } else {
        return Ok("MALFORM".to_string());
    };

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
    app.listen("192.168.0.112:8088" /*"10.0.0.90:8088"*/)
        .await?;
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
    let state = State { pool };

    // Start the server
    start(state).await
}
