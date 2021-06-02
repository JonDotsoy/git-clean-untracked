pub mod git_tool {
  use std::path::{Path, PathBuf};
  use termion::color;

  #[derive(Debug)]
  pub struct File {
    path: String,
    path_buf: PathBuf,
  }

  impl File {
    pub fn new(path_like: String) -> File {
      let path_buf = PathBuf::from(&path_like);

      File {
        path: path_like,
        path_buf: path_buf,
      }
    }

    pub fn exists(&self) -> bool {
      let exists = Path::new(&self.path).exists();
      exists
    }

    pub fn is_relative(&self) -> bool {
      let is_relative = Path::new(&self.path).is_relative();
      is_relative
    }

    pub fn to_str(self) -> String {
      let _a = "";
      self.path
    }
  }

  #[derive(Debug)]
  pub struct Git {
    pub files: Vec<File>,
  }

  impl Git {
    pub fn new() -> Self {
      Git { files: vec![] }
    }

    pub fn read_status_ignored(&mut self) {
      let output = std::process::Command::new("git")
        .args(&["status", "-s", "--ignored=matching", "-z"])
        .output()
        .expect("Err command: git status -s --ignored");

      let sol = output.stdout.split(|n| n == &0);

      for x in sol {
        if x.len() != 0 {
          let method_type = String::from(String::from_utf8_lossy(&x[0..2]));
          if method_type == "!!" {
            let path_like = String::from(String::from_utf8_lossy(&x[3..]));

            let path = PathBuf::from(&path_like)
              .canonicalize()
              .expect(&String::from(format!(
                "Not such file \"{}{}{}\"",
                color::Fg(color::Blue),
                &path_like,
                color::Fg(color::Reset),
              )));

            let path_str = match path.to_str() {
              Some(path_str) => path_str,
              _ => panic!("Err"),
            };

            self.files.push(File::new(String::from(path_str)));
          }
        }
      }
    }
  }
}
