use gloo::console::log;
use stylist::yew::styled_component;
use yew::prelude::*;

use crate::components::atoms::{button::Button, text_input::TextInput};

#[styled_component(CustomForm)]
pub fn custom_form() -> Html {
    let name_state = use_state(|| "".to_string());
    let name_state_clone = name_state.clone();
    let name_changed = Callback::from(move |name: String| {
        name_state_clone.set(name);
    });
    html! {
        <>
        <form>
            <TextInput name="url" handle_onchange={name_changed}/>
            <Button name="Convert" />
        </form>
        <div>{&*name_state}</div>
        </>
    }
}
