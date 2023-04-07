use gloo::console::log;
use stylist::yew::styled_component;
use wasm_bindgen::JsCast;
use web_sys::InputEvent;
use yew::prelude::*;

#[derive(Properties, PartialEq)]
pub struct Props {
    pub name: String,
    pub handle_onchange: Callback<String>,
}

#[styled_component(TextInput)]
pub fn text_input(props: &Props) -> Html {
    let handle_onchange = props.handle_onchange.clone();
    let onchange = Callback::from(move |event: InputEvent| {
        let target = event.target().unwrap();
        let value = target.unchecked_into::<web_sys::HtmlInputElement>().value();
        handle_onchange.emit(value);
    });
    html! {
        <input type="text" name={props.name.clone()} oninput={onchange}/>
    }
}
