use gloo::console::log;
use stylist::{style, yew::styled_component};
use wasm_bindgen::JsCast;
use yew::prelude::*;

#[derive(Properties, PartialEq)]
pub struct Props {
    pub name: String,
    pub handle_onchange: Callback<String>,
}

#[styled_component(TextInput)]
pub fn text_input(props: &Props) -> Html {
    let handle_onchange = props.handle_onchange.clone();
    let onchange = Callback::from(move |event: Event| {
        let target = event.target().unwrap();
        let value = target.unchecked_into::<web_sys::HtmlInputElement>().value();
        handle_onchange.emit(value);
    });
    html! {
        <input type="text" name={props.name.clone()} onchange={onchange}/>
    }
}
