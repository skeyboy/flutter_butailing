use axum::extract::{Path, Query, State};
use axum::Json;
use librqbit::api::{
    ApiAddTorrentResponse, EmptyJsonResponse, TorrentDetailsResponse, TorrentIdOrHash,
    TorrentListResponse,
};
pub use librqbit::dht::Id20;
use librqbit::session_stats::snapshot::SessionStatsSnapshot;
pub use librqbit::{AddTorrent, AddTorrentOptions, Api, ApiError, Session, TorrentStats};
pub use librqbit::{SessionOptions, SessionPersistenceConfig};
pub use serde::{Deserialize, Serialize};
pub use serde_json::json;
use std::collections::HashMap;
use std::path::PathBuf;
use std::str::FromStr;
use std::string::String;
use std::sync::{Arc, Mutex};

#[derive(Clone)]
pub struct AppState {
    pub work_dir: Option<String>,

    pub api: Option<Api>,
}

#[derive(Clone)]
pub struct ShareAppState {
    pub state: Arc<Mutex<Option<AppState>>>,
}

impl ShareAppState {
    pub fn new() -> Self {
        Self {
            state: Arc::new(Mutex::new(None)),
        }
    }
    pub(crate) fn api(&self) -> Option<Api> {
        Some(self.state.lock().unwrap().clone().unwrap().api?)
    }

    pub async fn start(&self, work_dir: String) -> Json<Result<SessionStatsSnapshot, ApiError>> {
        let mut opts = SessionOptions::default();
        let path = PathBuf::from(String::from(work_dir.clone()));
        // SessionPersistenceConfig::default_json_persistence_folder().unwrap();
        opts.persistence = Some(SessionPersistenceConfig::Json {
            folder: Some(path.to_owned()),
        });
        opts.dht_config = Some(librqbit::dht::PersistentDhtConfig {
            dump_interval: None,
            config_filename: Some(path.to_owned()),
        });
        let session = Session::new_with_opts(work_dir.clone().into(), opts)
            .await
            .unwrap();
        self.state.lock().unwrap().replace(AppState {
            work_dir: Some(work_dir),
            api: Some(Api::new(session, None)),
        });
        Json(Ok(self.api().unwrap().api_session_stats()))
    }
}
#[derive(Default, Serialize, Deserialize)]
pub struct TorrentCreateFromUrl {
    pub url: String,
    pub opts: Option<AddTorrentOptions>,
}

#[derive(Default, Serialize, Deserialize)]
pub struct TorrentIdOrHashRequest {
    pub id: Option<usize>,
    pub info_hash: Option<String>,
}

// torrent_action_delete?id=122&&info_hash=xxx [任选一]
pub async fn torrent_action_delete(
    State(state): State<Arc<ShareAppState>>,
    Query(value): Query<TorrentIdOrHashRequest>,
) -> Json<Result<EmptyJsonResponse, ApiError>> {
    match (value.id, value.info_hash) {
        (None, None) => todo!(),
        (None, Some(info_hash)) => {
            let id20 = Id20::from_str(info_hash.as_str()).unwrap();
            let result = state
                .api()
                .unwrap()
                .api_torrent_action_delete(TorrentIdOrHash::Hash(id20))
                .await;
            Json(result)
        }
        (Some(id), None) => Json(
            state
                .api()
                .unwrap()
                .api_torrent_action_delete(TorrentIdOrHash::Id(id))
                .await,
        ),
        (Some(id), Some(info_has)) => Json(
            state
                .api()
                .unwrap()
                .api_torrent_action_delete(TorrentIdOrHash::Id(id))
                .await,
        ),
    }
}

// torrent_create_from_url {url, opts}
pub(crate) async fn torrent_create_from_url(
    State(state): State<Arc<ShareAppState>>,
    Json(value): Json<TorrentCreateFromUrl>,
) -> Json<Result<ApiAddTorrentResponse, ApiError>> {
    Json(
        state
            .api()
            .unwrap()
            .api_add_torrent(AddTorrent::Url(value.url.into()), value.opts)
            .await,
    )
}

#[derive(Default, Serialize, Deserialize, Debug)]
pub struct QueryState {
    pub id: Option<usize>,
    pub hash: Option<Id20>,
}
// torrent_stats?info_hash=xxx
pub(crate) async fn torrent_stats(
    State(state): State<Arc<ShareAppState>>,
    Query(values): Query<HashMap<String, String>>, // Path(info_hash): Path<String>,
) -> Json<Result<TorrentStats, ApiError>> {
    println!("torrent_stats {:?}", values);
    let info_hash = values.get("info_hash").unwrap();
    Json(
        state
            .api()
            .unwrap()
            .api_stats_v1(TorrentIdOrHash::Hash(Id20::from_str(&*info_hash).unwrap())),
    )
}
// torrents_list
pub(crate) async fn torrents_list(
    State(state): State<Arc<ShareAppState>>,
) -> Json<TorrentListResponse> {
    Json(state.api().unwrap().api_torrent_list())
}

// details/<:id>
async fn torrent_details(
    State(state): State<Arc<ShareAppState>>,
    Path(id): Path<TorrentIdOrHash>,
) -> Json<Result<TorrentDetailsResponse, ApiError>> {
    Json(state.api().unwrap().api_torrent_details(id))
}

// add?magnet=xxx
pub(crate) async fn api_add_torrent(
    State(state): State<Arc<ShareAppState>>,
    Query(params): Query<HashMap<String, String>>,
) -> Json<Result<ApiAddTorrentResponse, ApiError>> {
    let magnet = params.get("magnet").unwrap();
    let result: Result<ApiAddTorrentResponse, ApiError> = state
        .api()
        .unwrap()
        .api_add_torrent(AddTorrent::from_url(magnet), None)
        .await;
    Json(result)
}

//  /state
pub(crate) async fn stats(State(state): State<Arc<ShareAppState>>) -> Json<SessionStatsSnapshot> {
    Json(state.api().unwrap().api_session_stats())
}

pub(crate) async fn torrent_action_configure(
    State(state): State<Arc<ShareAppState>>,
    id: TorrentIdOrHash,
    only_files: Vec<usize>,
) -> Json<EmptyJsonResponse> {
    Json(
        state
            .api()
            .unwrap()
            .api_torrent_action_update_only_files(id, &only_files.into_iter().collect())
            .await
            .expect("REASON"),
    )
}
