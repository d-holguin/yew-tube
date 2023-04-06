mod components;

use gloo::console::log;
use stylist::yew::{styled_component, Global};
use yew::prelude::*;
use yew::Html;

use crate::components::atoms::main_title::Color;
use crate::components::atoms::main_title::MainTitle;
use crate::components::molecules::custom_form::CustomForm;

#[styled_component(App)]
pub fn app() -> Html {
    log!("App initialized");
    let global_stylesheet = css!(
        r#"
        * {
            box-sizing: border-box;
        }
        html, body {
            margin: 0;
            padding: 0;
            min-height: 100%;
            height: 100%;
        }
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        "#,
    );

    let main_title_load = Callback::from(|message: String| log!(message));

    html! {
        <>
            <Global css={global_stylesheet.clone()} />
            <div class="container">
                <MainTitle  title="YewTube Converter" color={Color::Green} on_load={main_title_load}></MainTitle>
                <CustomForm/>
            </div>
        </>
    }
}
