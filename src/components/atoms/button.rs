use gloo::console::log;
use yew::prelude::*;

#[derive(Properties, PartialEq)]
pub struct Props {
    pub name: String,
    pub onclick: Callback<()>,
}

#[function_component(Button)]
pub fn button(props: &Props) -> Html {
    let styling = "bg-indigo-500 hover:bg-indigo-600 active:bg-indigo-700 text-white py-2 px-4 rounded-r-lg transition duration-200 transform-gpu active:scale-95";

    let custom_form_submit = {
        let onclick = props.onclick.clone();
        Callback::from(move |_| {
            log!("Button clicked");
            onclick.emit(());
        })
    };


    html! {
         <button type="button" class={styling} onclick={custom_form_submit}>{props.name.clone()}</button>
    }
}
