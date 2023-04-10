use stylist::yew::use_style;
use stylist::{style, yew::styled_component};
use yew::prelude::*;

#[derive(PartialEq, Properties)]
pub struct Props {
    pub title: String,
    pub color: Color,
    pub on_load: Callback<String>,
}

#[derive(PartialEq)]
pub enum Color {
    Normal,
    Blue,
    Green,
}

impl Color {
    pub fn to_string(&self) -> String {
        match self {
            Color::Normal => "text-black".to_string(),
            Color::Blue => "text-indigo-500 text-5xl font-bold ml-4".to_string(),
            Color::Green => "text-green text-5xl font-bold ml-4".to_string(),
        }
    }
}

#[function_component(MainTitle)]
pub fn main_title(props: &Props) -> Html {
    props.on_load.emit("MainTitle loaded".to_string());
    html! {
    <div class="flex flex-row items-center">
        <img class="w-16 h-16" src="assets/icons/yewtube.svg" alt="Icon" />
        <div class={&props.color.to_string()}>{ &props.title }</div>
    </div>
    }
}
