// LucianOS Desktop Shell — Minimal GTK4 prototype
// This is a lightweight GTK4 application that demonstrates a
// placeholder desktop area and a bottom taskbar with a Start button.

use gtk4::prelude::*;
use gtk4::{Application, ApplicationWindow, Button, Box as GtkBox, Label, Orientation, Align};

fn build_ui(app: &Application) {
    // Main window
    let window = ApplicationWindow::builder()
        .application(app)
        .title("LucianOS Shell — Prototype")
        .default_width(1200)
        .default_height(700)
        .build();

    // Vertical layout: desktop area above, taskbar below
    let vbox = GtkBox::new(Orientation::Vertical, 0);

    // Desktop area (placeholder)
    let desktop = Label::new(Some("\n\nLucianOS Desktop Area — placeholder\n\n"));
    desktop.set_hexpand(true);
    desktop.set_vexpand(true);
    desktop.set_margin_top(12);
    desktop.set_margin_bottom(12);
    desktop.set_margin_start(12);
    desktop.set_margin_end(12);
    vbox.append(&desktop);

    // Simple taskbar
    let taskbar = GtkBox::new(Orientation::Horizontal, 8);
    taskbar.set_valign(Align::End);
    taskbar.set_margin_bottom(6);
    taskbar.set_margin_start(6);
    taskbar.set_margin_end(6);

    let start_button = Button::with_label("Start");
    start_button.set_tooltip_text(Some("Open Start Menu (placeholder)"));
    taskbar.append(&start_button);

    // Add a couple of example app buttons
    let app_btn1 = Button::with_label("Browser");
    let app_btn2 = Button::with_label("Terminal");
    taskbar.append(&app_btn1);
    taskbar.append(&app_btn2);

    vbox.append(&taskbar);

    window.set_child(Some(&vbox));
    window.present();
}

fn main() {
    // Create GTK application
    let app = Application::builder()
        .application_id("org.lucianos.shell")
        .build();

    app.connect_activate(|app| build_ui(app));
    app.run();
}
