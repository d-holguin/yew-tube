mod components;

use gloo::console::log;
use wasm_bindgen::prelude::*;
use wasm_bindgen::JsCast;
use web_sys::{MessageEvent, Worker};
use yew::prelude::*;
use yew::Html;

use crate::components::atoms::main_title::Color;
use crate::components::atoms::main_title::MainTitle;
use crate::components::molecules::custom_form::CustomForm;

#[function_component(App)]
pub fn app() -> Html {
    log!("App initialized");
    let main_title_load = Callback::from(|message: String| log!(message));
    html! {
        <div class="h-screen flex flex-col justify-center items-center space-y-8">
            <MainTitle  title="YewTube Converter" color={Color::Blue} on_load={main_title_load}></MainTitle>
            <CustomForm/>
            <div class="mt-8"><Table/></div>

        </div>
    }
}

#[function_component(Table)]
pub fn table() -> Html {
    html! {
        <table class="max-w-lg w-full">
            <thead>
                <tr class="bg-gray-800">
                    <th class="py-2 px-4">{"File name"}</th>
                    <th class="py-2 px-4">{"Size"}</th>
                    <th class="py-2 px-4"></th>
                </tr>
            </thead>
            <tbody>
                <tr class="even:bg-gray-700 odd:bg-gray-600">
                    <td class="py-2 px-4">{"Cool_video.mp4"}</td>
                    <td class="py-2 px-4">{"8mb"}</td>
                    <td class="py-2 px-4">{"Download Button"}</td>
                </tr>
                <tr class="even:bg-gray-700 odd:bg-gray-600">
                    <td class="py-2 px-4">{"Cool_video_2.mp4"}</td>
                    <td class="py-2 px-4">{"16mb"}</td>
                    <td class="py-2 px-4">{"Download Button"}</td>
                </tr>
            </tbody>
        </table>
    }
}
