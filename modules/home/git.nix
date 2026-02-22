{ ... }:

{
  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Michael Alexander";
        email = "beefsack@gmail.com";
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
