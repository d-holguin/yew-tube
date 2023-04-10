use std::ops::Deref;

use stylist::yew::styled_component;
use web_sys::HtmlInputElement;
use yew::prelude::*;

#[derive(Properties, PartialEq)]
pub struct Props {
    pub name: String,
    pub handle_onchange: Callback<String>,
}

#[styled_component(TextInput)]
pub fn text_input(props: &Props) -> Html {
    let input_node_ref = use_node_ref();

    let input_value_handle = use_state(String::default);
    let input_value = input_value_handle.deref().clone();

    let onchange = {
        let input_node_ref = input_node_ref.clone();
        let handle_onchange = props.handle_onchange.clone();
        Callback::from(move |_| {
            let input = input_node_ref.cast::<HtmlInputElement>();
            if let Some(input) = input {
                let value = input.value();
                input_value_handle.set(value.clone());
                handle_onchange.emit(value);
            }
        })
    };

    html! {
        <input ref={input_node_ref}
            class="border border-neutral-700 py-2 px-4 rounded-l-lg flex-1 mr-2"
            name={props.name.clone()}
            type="text"
            placeholder={props.name.clone()}
            value={input_value}
            onchange={onchange}
        />
    }
}
