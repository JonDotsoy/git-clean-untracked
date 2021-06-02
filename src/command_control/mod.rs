pub mod command_control {
  use crate::git_tool::git_tool::Git;
  use termion::color;

  pub fn factory_command(command: Option<&String>, args: Option<&[String]>) {
    let comm = match command {
      Some(val) => val,
      _ => "help",
    };

    match comm {
      "remove" | "rm" => remove_command(),
      "info" | "i" => info_command(),
      "help" | "h" | _ => help_command(),
    }
  }

  fn remove_command() {
    let mut git = Git::new();

    git.track_status_ignored();

    for file in git.files {
      file.unlink();
    }
  }

  fn info_command() {
    let mut git = Git::new();

    git.track_status_ignored();

    for file in git.files {
      println!(
        " - {}{}{}",
        color::Fg(color::Red),
        file.to_str(),
        color::Fg(color::Reset),
      );
    }
  }

  fn help_command() {
    let help_text = vec![
      "usage: git clean-untracked [<command>]",
      "",
      "Commands:",
      "",
      "    info, i               List files to remove with command `rm`",
      "    remove, rm            Remove all files presented with command `info`",
      "    help                  Show this message",
      // "    -v, --verbose         be verbose",
    ];

    println!("{}", help_text.join("\n"));
  }
}
