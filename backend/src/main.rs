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

/// Insert a new user account into the database.
fn user_insert(
    client: &mut Client,
    username: &str,
    pswdsalt: u64,
    password: &str,
    emailadr: &str,
) -> Result<()> {
    // Build SQL Transaction
    let stmt = format!(
        "INSERT INTO users (username, pswdsalt, password, emailadr) \
         VALUES ('{}', x'{:X}'::bigint, '{}', '{}');",
        username, pswdsalt, password, emailadr
    );
    println!("Adding user: \"{}\"", stmt);
    client.execute(stmt.as_str(), &[])?;
    println!("Added user {}!", username);

    Ok(())
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
/// - `"INVALID"`: Username Taken
/// - `"FAILURE"`: Failed to connect to database
/// - `"MISSING"`: @ Is missing from email address.
async fn signup(mut request: tide::Request<State>) -> Result<String> {
    // Get the POST request data
    let post = request
        .body_string()
        .await
        .unwrap_or_else(|_| "".to_string());
    // Split the POST request data at newline characters.
    let mut lines = post.lines();
    // Connect to the database
    let mut connection = request.state().pool.get()?;

    // Test if username is in the database, return INVALID if it is.
    let username = if let Some(username) = lines.next() {
        if let Ok(exists) = user_exists(&mut connection, username) {
            if exists {
                return Ok("INVALID".to_string());
            }
        } else {
            return Ok("FAILURE".to_string());
        }
        username
    } else {
        return Ok("MALFORM".to_string());
    };

    // Grab Email.
    let email = if let Some(email) = lines.next() {
        if email.contains('@') {
            email
        } else {
            return Ok("MISSING".to_string());
        }
    } else {
        return Ok("MALFORM".to_string());
    };

    // Grab Password and Salt It.
    let (salt, password) = if let Some(password) = lines.next() {
        // Generate the salt
        let salt: u64 = rand::random();
        let tobe_hashed = format!("{}{:X}", password, salt);
        let hashed = sha256::sha(tobe_hashed);
        let hashed = {
            let mut out = String::new();
            for byte in hashed.iter() {
                write!(&mut out, "{:X}", byte).unwrap();
            }
            out
        };
        (salt, hashed)
    } else {
        return Ok("MALFORM".to_string());
    };

    // Make sure there's no extra lines
    if lines.next().is_some() {
        return Ok("MALFORM".to_string());
    }

    // Now that parsing has completed, add to database.
    let value = user_insert(&mut connection, username, salt, &password, email);
    if let Ok(()) = value {
        // Succeeded to log in.
        Ok("SUCCESS".to_string())
    } else {
        Ok("FAILURE".to_string())
    }
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

// Test page to verify that server is running and firewall is not blocked.
async fn test_page(_request: tide::Request<State>) -> Result<tide::Body> {
    let mut body = tide::Body::from_bytes(include_bytes!("testpage.html").to_vec());
    body.set_mime(tide::http::mime::HTML);

    Ok(body)
}

// Called after intialization, runs the HTTP server.
async fn start(state: State) -> Result<()> {
    async_std::println!("TIDE START").await;

    // Start server log
    tide::log::start();

    async_std::println!("TIDE START'D").await;

    // Configure HTTP server endpoints (POST only)
    let mut app = tide::with_state(state);
    app.at("/").get(test_page);
    app.at("/signup").post(signup);
    app.at("/log_in").post(log_in);

    async_std::println!("TIDE LISTEN").await;

    // Start serving HTTP server
    let r = app.listen("0.0.0.0:8000").await.map_err(|e| e.into()); 
    async_std::println!("TIDE DIE").await;
    r
}

// Entry point for the program
#[async_std::main]
async fn main() -> Result<()> {
    async_std::println!("GET USERNAME").await;
    // Grab username from the environment.
    let username = whoami::username();
    async_std::println!("GET USERNAME {}", username).await;
    // Build Unix Domain Socket URL
    let url = format!("postgres://{:}@%2Frun%2Fpostgresql/notescout", username);
    async_std::println!("GET URL {}", url).await;
    // Make PostgreSQL configuration from URL
    let config: Config = url.parse()?;
    async_std::println!("GET CONFIG").await;
    // Connect to the PostgreSQL database.
    let manager = PostgresConnectionManager::new(config, NoTls);
    async_std::println!("GET MGNER").await;
    // Build a connection pool ontop of the database.
    let pool = r2d2::Pool::new(manager).unwrap();
    async_std::println!("GET POUL").await;

    // Initialize server state.
    let state = State { pool };

    async_std::println!("TIDE STARTING…").await;

    // Start the server
    start(state).await
}
