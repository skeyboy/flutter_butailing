use axum::extract::{Path, Query, State};
use axum::response::IntoResponse;
use axum::Json;
use librqbit::api::{
    ApiAddTorrentResponse, EmptyJsonResponse, TorrentDetailsResponse, TorrentIdOrHash,
    TorrentListResponse,
};
pub use librqbit::dht::Id20;
use librqbit::session_stats::snapshot::SessionStatsSnapshot;
pub use librqbit::{AddTorrent, AddTorrentOptions, Api, ApiError, Session, TorrentStats};
use serde::{Deserialize, Serialize};
use serde_json::json;
 use std::collections::HashMap;
use std::str::FromStr;
use std::string::String;
use std::sync::Arc;

#[derive(Debug, Serialize)]
pub struct ApiResult<T> {
    data: Option<T>, // 可选的数据部分，包含请求成功时返回的数据
}

// 实现 `IntoResponse` trait 以将 ApiResult 转换为 Axum 响应
impl<T: Serialize> IntoResponse for ApiResult<T> {
    fn into_response(self) -> axum::response::Response {
        let val = json!(self); // 将 ApiResult 转换为 JSON 格式
        Json(val).into_response() // 将 JSON 响应转换为 Axum 的响应格式
    }
}

// 封装成功和错误响应
impl<T> ApiResult<T> {
    /// 成功响应
    /// 响应码为 200, 响应信息为 "success", data 为传入的 data 可选
    pub fn success(data: T) -> Self {
        Self {
            data: Some(data), // 包含成功时返回的数据
        }
    }
}

pub struct AppState {
    pub api:  Arc<Api>,
}

impl AppState {
    fn sessiom(&self)-> &std::sync::Arc<librqbit::Session> {
        self.api().session()
    }
    fn api(&self) -> &Api {
        return self.api.as_ref();
    }
}

#[derive(Default, Serialize, Deserialize)]
pub  struct TorrentCreateFromUrl {
    pub  url: String,
    pub  opts:Option<AddTorrentOptions>
}

#[derive(Default, Serialize, Deserialize)]
pub  struct TorrentIdOrHashRequest {
    pub id:Option<usize>,
    pub info_hash: Option<String>
}


// torrent_action_delete?id=122&&info_hash=xxx [任选一]
pub  async fn torrent_action_delete(
   State(state): State<Arc<AppState>>,
    Query(value): Query<TorrentIdOrHashRequest>,
) -> Json<EmptyJsonResponse> {
     match (value.id,value.info_hash) {
        (None, None) => todo!(),
        (None, Some(info_hash)) => {
            let id20 = Id20::from_str(info_hash.as_str()).unwrap();
            let result = state.api().api_torrent_action_delete(TorrentIdOrHash::Hash(id20)).await.unwrap();
          return  Json(result);
        },
        (Some(id), None) =>{
          return  Json(state.api().api_torrent_action_delete(  TorrentIdOrHash::Id(id)).await.unwrap());
        },
        (Some(id), Some(info_has)) => {return  Json(state.api().api_torrent_action_delete(  TorrentIdOrHash::Id(id)).await.unwrap());}
    }
}

// torrent_create_from_url {url, opts}
pub(crate) async fn torrent_create_from_url(
    State(state): State<Arc<AppState>>,
   Json(value): Json<TorrentCreateFromUrl>
) -> Json<ApiAddTorrentResponse> {
    Json(
        state
            .api()
            .api_add_torrent(AddTorrent::Url(value.url.into()), value.opts)
            .await.unwrap()
    )
}

#[derive(Default, Serialize, Deserialize, Debug)]
pub struct QueryState {
    pub id: Option<usize>,
    pub hash: Option<Id20>,
}
// torrent_stats?info_hash=xxx
pub(crate) async fn torrent_stats(
    State(state): State<Arc<AppState>>,
    Query(values): Query<HashMap<String, String>>, // Path(info_hash): Path<String>,
) -> Json<ApiResult<TorrentStats>> {
    println!("torrent_stats {:?}", values);
    let info_hash = values.get("info_hash").unwrap();
    Json(ApiResult::success(
        state
            .api()
            .api_stats_v1(TorrentIdOrHash::Hash(Id20::from_str(&*info_hash).unwrap()))
            .unwrap(),
    ))
}
// torrents_list
pub(crate) async fn torrents_list(
    State(state): State<Arc<AppState>>,
) -> Json<ApiResult<TorrentListResponse>> {
    Json(ApiResult::success(state.api().api_torrent_list().into()))
}

// details/<:id>
async fn torrent_details(
    State(state): State<Arc<AppState>>,
    Path(id): Path<TorrentIdOrHash>,
) -> Json<ApiResult<TorrentDetailsResponse>> {
    Json(ApiResult::success(state.api().api_torrent_details(id).unwrap()))
}
pub(crate) async fn api_start(State(state): State<Arc<AppState>>){

}
// add?magnet=xxx
pub(crate) async fn api_add_torrent(
    State(state): State<Arc<AppState>>,
    Query(params): Query<HashMap<String, String>>,
) -> Json<ApiAddTorrentResponse> {
    let magnet = params.get("magnet").unwrap();
    let result = state
        .api
        .as_ref()
        .api_add_torrent(AddTorrent::from_url(magnet), None)
        .await
        .unwrap();
    return Json(result);
}

//  /state
pub(crate) async fn stats(State(state): State<Arc<AppState>>) -> Json<ApiResult<SessionStatsSnapshot>> {
    return Json(ApiResult::success(state.api.as_ref().api_session_stats()));
}

pub(crate) async fn torrent_action_configure(
    State(state): State<Arc<AppState>>,
    id: TorrentIdOrHash,
    only_files: Vec<usize>,
) -> Json<EmptyJsonResponse> {
    Json(
        state
            .api
            .api_torrent_action_update_only_files(id, &only_files.into_iter().collect())
            .await
            .expect("REASON"),
    )
}
