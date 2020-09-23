use tide::Result;

/// State of the server backend.
#[derive(Clone)]
pub struct State {
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

#[async_std::main]
async fn main() -> Result<()> {
    let state = State {
    };

    tide::log::start();
    let mut app = tide::with_state(state);
    app.at("/signup").post(signup);
    app.at("/log_in").post(log_in);
    app.listen("192.168.0.112:8088" /*"10.0.0.90:8088"*/).await?;
    Ok(())
}
