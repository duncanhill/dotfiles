defmodule Dotfiles do
  def setup do
    targets = [
      {"doom.d", ".doom.d", &doom/0}
    ]

    for target <- targets do
      apply_target(target)
    end
  end

  defp apply_target({source, target}) do
    source_dir = Path.join(__DIR__, source) |> Path.expand()
    target_dir = Path.join("~/", target) |> Path.expand()

    IO.puts("Linking #{source_dir} to #{target_dir}")

    if File.exists?(target_dir) do
      IO.puts("  > Skipping. Directory already exists.")
    else
      File.ln_s!(source_dir, target_dir)
      IO.puts("  > Done.")
    end
  end

  defp apply_target({source, target, post_install}) do
    apply_target({source, target})
    post_install.()
  end

  defp doom do
    # Install doom dependencies.
    IO.puts("\nInstalling ripgrep...")
    System.cmd("brew", ["install", "ripgrep"], into: IO.stream())
    IO.puts("\nInstalling fd...")
    System.cmd("brew", ["install", "fd"], into: IO.stream())
    IO.puts("")

    # Install doom itself.
    emacs_dir = Path.expand("~/.emacs.d")
    if !File.exists?(emacs_dir) do
      System.cmd("git", ["clone", "--depth", "1", "https://github.com/doomemacs/doomemacs", emacs_dir], into: IO.stream())
      IO.puts("Manual step required: ~/.emacs.d/bin/doom install")
    end
  end
end

Dotfiles.setup()

