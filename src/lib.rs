use gloo::console::log;
use stylist::yew::styled_component;
use yew::prelude::*;

mod components;

use components::atoms::main_title::MainTitle;

#[styled_component(App)]
pub fn app() -> Html {
    log!("Styled component rendered!");
    let stylesheet = css!(
        r#"
        .container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        "#
    );
    html! {
        <div class={stylesheet.clone()}>
            <div class="container">
                <MainTitle title="prop title"></MainTitle>
            </div>
        </div>
    }
}
