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
            Color::Normal => "normal".to_string(),
            Color::Blue => "blue".to_string(),
            Color::Green => "green".to_string(),
        }
    }
}

#[styled_component(MainTitle)]
pub fn main_title(props: &Props) -> Html {
    let style = style!(
        r#"
    .green {
        color: green;
    }
    .blue {
        color: blue;
    }
    .normal {
        color: black;
    }
   "#
    )
    .unwrap();

    props.on_load.emit("MainTitle loaded".to_string());

    html! {
    <div class={style}>
        <div class={&props.color.to_string()}>{ &props.title }</div>
    </div>
    }
}
