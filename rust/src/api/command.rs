use http::StatusCode;
use librqbit::{AddTorrent, AddTorrentOptions, ApiError, TorrentStats, api::{ApiAddTorrentResponse, EmptyJsonResponse, TorrentDetailsResponse, TorrentIdOrHash, TorrentListResponse}, session_stats::snapshot::SessionStatsSnapshot};

use crate::api::{config::{self, RqbitDesktopConfig}, main_state::{CurrentState, State}};
    use base64::{Engine as _, engine::general_purpose};

#[flutter_rust_bridge::frb(sync)]
pub  fn config_default() -> config::RqbitDesktopConfig {
    config::RqbitDesktopConfig::default()
}

#[flutter_rust_bridge::frb(sync)]
fn config_current(state: &State) -> CurrentState {
    let g = state.shared.read();
    match &*g {
        Some(s) => CurrentState {
            config: Some(s.config.clone()),
            configured: s.api.is_some(),
        },
        None => Default::default(),
    }
}


#[flutter_rust_bridge::frb(sync)]
async fn config_change(
    state:  &State,
    config: RqbitDesktopConfig,
) -> Result<EmptyJsonResponse, ApiError> {
    state.configure(config).await.map(|_| EmptyJsonResponse {})
}


#[flutter_rust_bridge::frb(sync)]
fn torrents_list( state:  &State) -> Result<TorrentListResponse, ApiError> {
    Ok(state.api()?.api_torrent_list())
}

#[flutter_rust_bridge::frb(sync)]
async fn torrent_create_from_url(
    state:  &State,
    url: String,
    opts: Option<AddTorrentOptions>,
) -> Result<ApiAddTorrentResponse, ApiError> {
    state
        .api()?
        .api_add_torrent(AddTorrent::Url(url.into()), opts)
        .await
}




// #[flutter_rust_bridge::frb(sync)]
// async fn torrent_create_from_base64_file(
//     state:  &State,
//     contents: String,
//     opts: Option<AddTorrentOptions>,
// ) -> Result<ApiAddTorrentResponse, ApiError> {
//      let bytes = general_purpose::STANDARD
//         .decode(&contents).with_status_error(StatusCode::BAD_REQUEST, "invalid base64")?
//         // .with_status_error(StatusCode::BAD_REQUEST, "invalid base64")?
//         ;
//     state
//         .api()?
//         .api_add_torrent(AddTorrent::TorrentFileBytes(bytes.into()), opts)
//         .await
// }

#[flutter_rust_bridge::frb(sync)]
async fn torrent_details(
    state: &State,
    id: TorrentIdOrHash,
) -> Result<TorrentDetailsResponse, ApiError> {
    state.api()?.api_torrent_details(id)
}


#[flutter_rust_bridge::frb(sync)]
async fn torrent_stats(
   state: &State,
    id: TorrentIdOrHash,
) -> Result<TorrentStats, ApiError> {
    state.api()?.api_stats_v1(id)
}


#[flutter_rust_bridge::frb(sync)]
async fn torrent_action_delete(
   state: &State,
    id: TorrentIdOrHash,
) -> Result<EmptyJsonResponse, ApiError> {
    state.api()?.api_torrent_action_delete(id).await
}




#[flutter_rust_bridge::frb(sync)]
async fn torrent_action_pause(
    state: &State,
    id: TorrentIdOrHash,
) -> Result<EmptyJsonResponse, ApiError> {
    state.api()?.api_torrent_action_pause(id).await
}

#[flutter_rust_bridge::frb(sync)]
async fn torrent_action_forget(
    state: &State,
    id: TorrentIdOrHash,
) -> Result<EmptyJsonResponse, ApiError> {
    state.api()?.api_torrent_action_forget(id).await
}

#[flutter_rust_bridge::frb(sync)]
async fn torrent_action_start(
    state: &State,
    id: TorrentIdOrHash,
) -> Result<EmptyJsonResponse, ApiError> {
    state.api()?.api_torrent_action_start(id).await
}

#[flutter_rust_bridge::frb(sync)]
async fn torrent_action_configure(
    state: &State,
    id: TorrentIdOrHash,
    only_files: Vec<usize>,
) -> Result<EmptyJsonResponse, ApiError> {
    state
        .api()?
        .api_torrent_action_update_only_files(id, &only_files.into_iter().collect())
        .await
}

#[flutter_rust_bridge::frb(sync)]
async fn stats(state:  &State) -> Result<SessionStatsSnapshot, ApiError> {
    Ok(state.api()?.api_session_stats())
}

#[flutter_rust_bridge::frb(sync)]
fn get_version() -> &'static str {
    env!("CARGO_PKG_VERSION")
}
