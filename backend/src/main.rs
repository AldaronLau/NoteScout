#![forbid(unsafe_code)]

use std::fmt::Write;

use postgres::{
    config::Config, fallible_iterator::FallibleIterator, Client, NoTls,
};
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
    let _post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    let mut _out = String::new();

    /*match _post {
        _ => {}
    }*/

    Ok(_out)
}

/// Check if a user exists in the database.
fn user_exists(client: &mut Client, username: &str) -> Result<bool> {
    // Build SQL Prepared Statement
    let mut trans = client.transaction()?;
    let stmt =
        format!("SELECT USERNAME FROM USERS WHERE USERNAME='{}';", username);
    let prep = trans.prepare(&stmt)?;

    // Execute SQL Prepared Statement
    let portal = trans.bind(&prep, &[])?;
    let rows = trans.query_portal_raw(&portal, 50)?;

    // Interpret results
    Ok(rows.count()? == 1)
}

/// Retreive the user's salt from the database.
fn user_salt(client: &mut Client, username: &str) -> Result<Option<i64>> {
    // Build SQL Prepared Statement
    let mut trans = client.transaction()?;
    let stmt =
        format!("SELECT PSWDSALT FROM USERS WHERE USERNAME='{}';", username);
    let prep = trans.prepare(&stmt)?;

    // Execute SQL Prepared Statement
    let portal = trans.bind(&prep, &[])?;
    let mut rows = trans.query_portal_raw(&portal, 50)?;

    // Interpret results
    if let Some(salt) = rows.next()? {
        if rows.next()?.is_some() {
            return Ok(None);
        }
        Ok(Some(salt.get(0)))
    } else {
        Ok(None)
    }
}

/// Retreive the user's salted password from the database.
fn user_password(
    client: &mut Client,
    username: &str,
) -> Result<Option<String>> {
    // Build SQL Prepared Statement
    let mut trans = client.transaction()?;
    let stmt =
        format!("SELECT PASSWORD FROM USERS WHERE USERNAME='{}';", username);
    let prep = trans.prepare(&stmt)?;

    // Execute SQL Prepared Statement
    let portal = trans.bind(&prep, &[])?;
    let mut rows = trans.query_portal_raw(&portal, 50)?;

    // Interpret results
    if let Some(salt) = rows.next()? {
        if rows.next()?.is_some() {
            return Ok(None);
        }
        Ok(Some(salt.get(0)))
    } else {
        Ok(None)
    }
}

/// Called when the user posts to /log_in
///
/// # Recv
/// ```
/// "USERNAME\nPASSWORD"
/// ```
///
/// # Send
/// - `"MALFORM"`: Post Request Is Malformed
/// - `"SUCCESS"`: Log In Succeeded
/// - `"INVALID"`: Invalid Username Password Combination
/// - `"MISSING"`: User is Missing From Database
/// - `"FAILURE"`: Failed to connect to database
async fn log_in(mut request: tide::Request<State>) -> Result<String> {
    // Get the POST request data
    let post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    // Split the POST request data at newline characters.
    let mut lines = post.lines();
    // Connect to the database
    let mut connection = request.state().pool.get()?;

    // Test if username is in the database
    let username = if let Some(username) = lines.next() {
        if let Ok(exists) = user_exists(&mut connection, username) {
            if exists {
                username
            } else {
                return Ok("MISSING".to_string());
            }
        } else {
            return Ok("FAILURE".to_string());
        }
    } else {
        return Ok("MALFORM".to_string());
    };

    // Test if password matches
    let matches = if let Some(password) = lines.next() {
        if let Ok(Some(salt)) = user_salt(&mut connection, username) {
            let tobe_hashed = format!("{}{:X}", password, salt);
            let hashed = sha256::sha(tobe_hashed);
            let hashed = {
                let mut out = String::new();
                for byte in hashed.iter() {
                    write!(&mut out, "{:X}", byte).unwrap();
                }
                out
            };
            if let Ok(Some(pswd)) = user_password(&mut connection, username) {
                hashed == pswd
            } else {
                return Ok("FAILURE".to_string());
            }
        } else {
            return Ok("FAILURE".to_string());
        }
    } else {
        return Ok("MALFORM".to_string());
    };
    // Fail to log in if passwords don't match
    if !matches {
        return Ok("INVALID".to_string());
    }

    // Make sure there's no extra lines
    if lines.next().is_some() {
        return Ok("MALFORM".to_string());
    }

    // Succeeded to log in.
    Ok("SUCCESS".to_string())
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
    app.listen(/*"192.168.0.112:8088"*/ "10.0.0.90:8000")
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
