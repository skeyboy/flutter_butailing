pub use crate::api::command::*;
pub use crate::api::ArcSession;
pub use axum::{
    http::StatusCode,
    routing::{get, post},
    Json, Router,
};
pub use flutter_rust_bridge::frb;
pub use librqbit::api::{ApiAddTorrentResponse, TorrentDetailsResponse, TorrentIdOrHash};
pub use librqbit::{session_stats::snapshot::SessionStatsSnapshot, ApiError};
pub use librqbit::{AddTorrent, Api, ManagedTorrent, Session};
pub use serde::{Deserialize, Serialize};
pub use std::sync::Arc;
pub use tower_http::follow_redirect::policy::PolicyExt;
pub use tower_http::{
    services::{ServeDir, ServeFile},
    trace::TraceLayer,
};
use crate::api::command::*;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

pub use axum::extract::State;
use tracing::info;

#[frb]
#[tokio::main]
pub async fn config(dest_dir: &str) {
    // build our application with a route
    println!("listening on 0.0.0:8888");
    let   session = Session::new(dest_dir.into()).await.unwrap();
    let api = Api::new(session, None);
 

    let shared_state = Arc::new(AppState { api: Arc::new(api) });

    let app = Router::new()
        // .nest_service("/documents", ServeDir::new(documents))
        // `GET /` goes to `root`
        .route("/api/v1/start", get(api_start))
        .route("/api/v1/add_torrent", get(api_add_torrent))
        .route("/api/v1/torrent_stats", get(torrent_stats))
        .route("/api/v1/stats", get(stats))
        .route("/api/v1/torrents_list", get(torrents_list))
        .route("/api/v1/torrent_create_from_url", post(torrent_create_from_url))
        .route("/api/v1/torrent_action_delete", get(torrent_action_delete))
        // .route("/api/v1/torrent_details", get(torrent_details))
        // .route("/api/v1/add_magnet", post(add_magnet))
        // .route("/api/v1/session_stats", get(session_stats))
        // .route("/api/v1/add_torrent", post(add_torrent))
        .route("/", get(root))
        // `POST /users` goes to `create_user`
        .route("/users", post(create_user))
        .with_state(shared_state);

    // run our app with hyper, listening globally on port 3000
    let listener = tokio::net::TcpListener::bind("0.0.0.0:8888").await.unwrap();
    info!("rust_demo listening on {}", listener.local_addr().unwrap());

    axum::serve(listener, app).await.unwrap();
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
    return session;
}

// #[frb]
// pub async fn add_magnet(session:ArcSession, magnet: &str) {
//     // let session = Session::new(dest_dir.into()).await.unwrap();
//     // let shared = Arc::new(session);
//     // let api = Api::new(*shared.clone(), None);

//     // let result = api.api_add_torrent(AddTorrent::from_url(magnet), None);

//     let managed_torrent_handle = session
//         .add_torrent(
//             // "magnet:?xt=urn:btih:cab507494d02ebb1178b38f2e9d7be299c86b862"
//             AddTorrent::from_url(magnet),
//             None, // options
//         )
//         .await
//         .unwrap()
//         .into_handle()
//         .unwrap();
//     managed_torrent_handle.wait_until_completed().await.unwrap();
// }

#[frb]
pub async fn get_api(session: Arc<Session>) -> Arc<Api> {
    return Arc::new(Api::new(session, None));
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
    return result;
}

#[frb]
pub async fn session_stats(api: Arc<Api>) -> Result<SessionStatsSnapshot, ApiError> {
    return Ok(api.as_ref().api_session_stats());
}
#[frb]
pub async fn add_torrent(api: Arc<Api>, torrent: &str) -> ApiAddTorrentResponse {
    return api
        .as_ref()
        .api_add_torrent(AddTorrent::from_url(torrent), None)
        .await
        .unwrap();
}

#[frb]
pub async fn add_magnet(api: Arc<Api>, magnet: &str) -> ApiAddTorrentResponse {
    let result: ApiAddTorrentResponse = api
        .as_ref()
        .api_add_torrent(AddTorrent::from_url(magnet), None)
        .await
        .unwrap();
    return result;
}
