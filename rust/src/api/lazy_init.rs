use librqbit::tracing_subscriber_config_utils::{init_logging, InitLoggingOptions};
use tracing::{debug_span, error, info, warn};
use crate::api::main_state::{State};

#[flutter_rust_bridge::frb(sync)] 
 async fn start() {
    let init_logging_result = init_logging(InitLoggingOptions {
        default_rust_log_value: Some("info"),
        log_file: None,
        log_file_rust_log: None,
    })
        .unwrap();

    match librqbit::try_increase_nofile_limit() {
        Ok(limit) => info!(limit = limit, "increased open file limit"),
        Err(e) => warn!("failed increasing open file limit: {:#}", e),
    };

    let state = State::new(init_logging_result).await;

}

#[flutter_rust_bridge::frb(sync)] 
pub  fn main_entry() {
    tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build()
        .expect("couldn't set up tokio runtime")
        .block_on(start())
}
