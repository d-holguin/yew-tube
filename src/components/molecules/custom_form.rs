use std::ops::Deref;

use gloo::console::log;
use serde::{Deserialize, Serialize};
use wasm_bindgen_futures::spawn_local;
use yew::prelude::*;

use crate::components::atoms::{button::Button, text_input::TextInput};

#[derive(Default, Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct FormData {
    pub url: String,
    pub format: String,
}
#[derive(Properties, PartialEq)]
pub struct Props {
    pub onsubmit: Callback<FormData>,
}

#[function_component(CustomForm)]
pub fn custom_form() -> Html {
    let state = use_state(|| FormData::default());

    let cloned_state = state.clone();
    let set_video_url_on_change = Callback::from(move |url: String| {
        cloned_state.set(FormData {
            url,
            ..cloned_state.deref().clone()
        });
    });

    let cloned_state = state.clone();
    let set_format_on_change = Callback::from(move |format: String| {
        cloned_state.set(FormData {
            format,
            ..cloned_state.deref().clone()
        });
    });

    let cloned_state = state.clone();

    let submit_form = Callback::from(move |_| {
        log!("Form submitted");
        let data = cloned_state.deref().clone();
        let json_string = serde_json::to_string(&data).unwrap();
        log!(json_string);
        //
        spawn_local(async move {
            log!("Fetching video");
        });
    });

    html! {
        <>
            <form class="bg-gray-700 rounded p-2">
                <TextInput name="url" handle_onchange={set_video_url_on_change}/>
                <TextInput name="format" handle_onchange={set_format_on_change}/>
                <Button name="Convert"  onclick={submit_form}/>
            </form>
            <div class="bg-neutral-500 rounded p-2">
                <p>
                    <a target="_blank" href={state.url.to_string()} class="text-blue-400 hover:text-blue-500">
                        {format!("Download {}", state.url.to_string())}
                    </a>
                </p>
            </div>
        </>
    }
}
