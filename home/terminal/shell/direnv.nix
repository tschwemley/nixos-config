{
  programs.direnv = {
    enable = true;
    # config =
    # /*
    # toml
    # */
    # ''
    #   [global]
    #   hide_env_diff = true
    # '';
    enableZshIntegration = true;
    # nix-direnv.enable = true;
    # stdlib =
    #   /*
    #   bash
    #   */
    #   ''
    #     # Usage: daemonize <name> [<command> [...<args>]]
    #     #
    #     # Starts the command in the background with an exclusive lock on $name.
    #     #
    #     # If no command is passed, it uses the name as the command.
    #     #
    #     # Logs are in .direnv/$name.log
    #     #
    #     # To kill the process, run `kill $(< .direnv/$name.pid)`.
    #     daemonize() {
    #       local name=$1
    #       shift
    #       local pid_file=$(direnv_layout_dir)/$name.pid
    #       local log_file=$(direnv_layout_dir)/$name.log
    #
    #       if [[ $# -lt 1 ]]; then
    #         cmd=$name
    #       else
    #         cmd=$1
    #         shift
    #       fi
    #
    #       if ! has "$cmd"; then
    #         echo "ERROR: $cmd not found"
    #         return 1
    #       fi
    #
    #       mkdir -p "$(direnv_layout_dir)"
    #
    #       # Open pid_file on file descriptor 200
    #       exec 200>"$pid_file"
    #
    #       # Check that we have exclusive access
    #       if ! flock --nonblock 200; then
    #         echo "daemonize[$name] is already running as pid $(< "$pid_file")"
    #         return
    #       fi
    #
    #       # Start the process in the background. This requires two forks to escape the
    #       # control of bash.
    #
    #       # First fork
    #       (
    #         # Second fork
    #         (
    #           echo "daemonize[$name:$BASHPID]: starting $cmd $*" >&2
    #
    #           # Record the PID for good measure
    #           echo "$BASHPID" >&200
    #
    #           # Redirect standard file descriptors
    #           exec 0</dev/null
    #           exec 1>"$log_file"
    #           exec 2>&1
    #           # Used by direnv
    #           exec 3>&-
    #           exec 4>&-
    #
    #           # Run command
    #           exec "$cmd" "$@"
    #         ) &
    #       ) &
    #
    #       # Release that file descriptor
    #       exec 200>&-
    #     }
    #
    #     kill-daemon() {
    #       # To kill the process, run `kill $(< .direnv/$name.pid)`.
    #       local name=$1
    #       shift
    #       local pid_file=$(direnv_layout_dir)/$name.pid
    #       kill $pid_file
    #     }
    #   '';
  };
}
