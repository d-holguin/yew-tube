

use gloo::console::log;
use stylist::{style, yew::styled_component};
use yew::prelude::*;

#[derive(Properties, PartialEq)]
pub struct Props {
    pub name: String,
}

#[styled_component(Button)]
pub fn button(props: &Props) -> Html {
    html! {
         <button type="button">{props.name.clone()}</button>
    }
}
