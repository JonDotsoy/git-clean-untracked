mod git_tool;

mod command_control;
use command_control::command_control::factory_command;

fn args_to_vec() -> Vec<String> {
  let args = std::env::args();
  let mut vec_args = vec![];

  for arg in args {
    vec_args.push(arg);
  }

  return vec_args;
}

fn main() {
  let args = args_to_vec();
  let action = args.get(1);
  let next_args = args.get(2..);

  factory_command(action, next_args);
}
