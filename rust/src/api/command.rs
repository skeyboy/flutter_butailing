use crate::api::{config};

#[flutter_rust_bridge::frb(sync)]
pub  fn config_default() -> config::RqbitDesktopConfig {
    config::RqbitDesktopConfig::default()
}

// #[flutter_rust_bridge::frb(sync)]
// pub fn config_current(state: tauri::State<'_, State>) -> CurrentState {
//     let g = state.shared.read();
//     match &*g {
//         Some(s) => CurrentState {
//             config: Some(s.config.clone()),
//             configured: s.api.is_some(),
//         },
//         None => Default::default(),
//     }
// }
