extern crate termion;

use crate::git_tool::git_tool::Git;

pub mod command_control {
  use crate::git_tool::git_tool::Git;

  pub fn factory_command(command: Option<&String>, args: Option<&[String]>) {
    let comm = match command {
      Some(val) => val,
      _ => "help",
    };

    match comm {
      "info" | "i" => info_command(),
      "help" | "h" | _ => help_command(),
    }
  }

  fn info_command() {
    let mut git = Git::new();

    git.read_status_ignored();

    for file in git.files {
      println!(
        " - {}{}",
        termion::color::Fg(termion::color::Red),
        file.to_str()
      );
    }
  }

  fn help_command() {
    println!("Help");
  }
}
