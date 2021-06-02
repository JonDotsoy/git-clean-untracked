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
  let _guard = sentry::init((
    "https://aff1dae4a3254225909afb3017eb387e@o345030.ingest.sentry.io/5797907",
    sentry::ClientOptions {
      release: sentry::release_name!(),
      ..Default::default()
    },
  ));

  let args = args_to_vec();
  let action = args.get(1);
  let next_args = args.get(2..);

  factory_command(action, next_args);
}
