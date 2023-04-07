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
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        html {
            background-color: #191b1c !important;
            font-size: 16px; /* Base font size */
        }
        
        body {
            margin: 0;
            padding: 0;
            min-height: 100%;
            height: 100%;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen,
                Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            line-height: 1.5;
            color: #f0f0f0;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .yewtube-icon {
            width: 3rem; 
            height: 3rem; 
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
