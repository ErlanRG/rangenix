{ host, ... }:

{
  programs.git = {
    enable = true;

    userName = "Erlan Rangel";
    userEmail = "erlanrangel@gmail.com";
    signing = {
      key = "C08D32B9B3F1C69D329F616870748C8750E3B083";
      signByDefault = true;
    };

    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      color.ui = "auto";
      init.defaultBranch = "main";
      diff.tool = "nvimdiff";
      log.showSignature = true;
    };
  };
}
