pub use crate::api::command::*;
pub use crate::api::ArcSession;
pub use axum::{
    http::StatusCode,
    routing::{get, post},
    Error, Json, Router,
};
pub use flutter_rust_bridge::frb;
pub use librqbit::api::{ApiAddTorrentResponse, TorrentDetailsResponse, TorrentIdOrHash};
pub use librqbit::SessionPersistenceConfig;
pub use librqbit::{session_stats::snapshot::SessionStatsSnapshot, ApiError, SessionOptions};
pub use librqbit::{AddTorrent, Api, ManagedTorrent, Session};
pub use serde::{Deserialize, Serialize};
pub use std::sync::Arc;
pub use std::sync::Mutex;
pub use tower_http::follow_redirect::policy::PolicyExt;
pub use tower_http::set_status::SetStatus;
pub use tower_http::{
    services::{ServeDir, ServeFile},
    trace::TraceLayer,
};

#[frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

pub use axum::extract::State;
use tracing::info;

#[frb]
#[tokio::main]
pub async fn start_service(
    dest_dir: &str,
    addr: Option<String>,
    port: Option<i32>,
) -> Result<(), std::io::Error> {
    // build our application with a route
    println!("start_service listening on :8888");

    println!("config(dest_dir: ");
    let shared_state = Arc::new(ShareAppState {
        state: Arc::new(Mutex::new(None)),
    });
    let session_result = shared_state.start(String::from(dest_dir)).await;
    info!("session_result start result {:?}", session_result);

    let app = Router::new()
        .nest_service("/assets", static_file_service(dest_dir))
        .nest_service("/static", ServeDir::new(dest_dir))
        .route("/api/v1/add_torrent", get(api_add_torrent))
        .route("/api/v1/torrent_stats", get(torrent_stats))
        .route("/api/v1/stats", get(stats))
        .route("/api/v1/torrents_list", get(torrents_list))
        .route(
            "/api/v1/torrent_create_from_url",
            post(torrent_create_from_url),
        )
        .route("/api/v1/torrent_action_delete", get(torrent_action_delete))
        // .route("/api/v1/torrent_details", get(torrent_details))
        // .route("/api/v1/add_magnet", post(add_magnet))
        // .route("/api/v1/session_stats", get(session_stats))
        // .route("/api/v1/add_torrent", post(add_torrent))
        .route("/", get(root))
        // `POST /users` goes to `create_user`
        .route("/users", post(create_user))
        .layer(TraceLayer::new_for_http())
        .with_state(shared_state);

    // run our app with hyper, listening globally on port 3000
    let listener = tokio::net::TcpListener::bind(format!(
        "{}:{}",
        addr.unwrap_or(String::from("0.0.0.0")),
        port.unwrap_or(8888)
    ))
    .await?;
    info!("rust_demo listening on {}", listener.local_addr()?);

    axum::serve(listener, app).await
}

fn static_file_service(path: &str) -> ServeDir<SetStatus<ServeFile>> {
    ServeDir::new(path)
        .append_index_html_on_directories(true)
        .not_found_service(ServeFile::new("assets/404.html"))
}

// basic handler that responds with a static string
async fn root() -> &'static str {
    "Hello, World!"
}

async fn create_user(
    // this argument tells axum to parse the request body
    // as JSON into a `CreateUser` type
    Json(payload): Json<CreateUser>,
) -> (StatusCode, Json<User>) {
    // insert your application logic here
    let user = User {
        id: 1337,
        username: payload.username,
    };

    // this will be converted into a JSON response
    // with a status code of `201 Created`
    (StatusCode::CREATED, Json(user))
}

// the input to our `create_user` handler
#[derive(Deserialize)]
struct CreateUser {
    username: String,
}

// the output to our `create_user` handler
#[derive(Serialize)]
struct User {
    id: u64,
    username: String,
}

#[frb]
pub async fn config_session(dest_dir: &str) -> ArcSession {
    let session = Session::new(dest_dir.into()).await.unwrap();
    session
}

#[frb]
pub async fn get_api(session: Arc<Session>) -> Arc<Api> {
    Arc::new(Api::new(session, None))
}

#[frb]
pub async fn torrent_details(
    api: Arc<Api>,
    add_torrent: ApiAddTorrentResponse,
) -> TorrentDetailsResponse {
    let result = api
        .as_ref()
        .api_torrent_details(TorrentIdOrHash::Id(add_torrent.id.unwrap()))
        .unwrap();
    result
}

#[frb]
pub async fn session_stats(api: Arc<Api>) -> Result<SessionStatsSnapshot, ApiError> {
    Ok(api.as_ref().api_session_stats())
}
#[frb]
pub async fn add_torrent(api: Arc<Api>, torrent: &str) -> ApiAddTorrentResponse {
    api.as_ref()
        .api_add_torrent(AddTorrent::from_url(torrent), None)
        .await
        .unwrap()
}

#[frb]
pub async fn add_magnet(api: Arc<Api>, magnet: &str) -> ApiAddTorrentResponse {
    let result: ApiAddTorrentResponse = api
        .as_ref()
        .api_add_torrent(AddTorrent::from_url(magnet), None)
        .await
        .unwrap();
    result
}
