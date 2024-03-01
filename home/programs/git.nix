{ ... }: {
  programs.git = {
    enable = true;
    aliases = {
      g = "git";
      a = "add";
      cm = "commit -m";
      st = "status";
      br = "branch";
      ch = "checkout";

      # More commands in one
      aa = "!git add -A && git status";
      cma = "!git add -A && git commit -m";

      ac = "!git add . && git commit -m \"$1\" && :";
      acp = "!git add . && git commit -m \"$1\" && git push";
      acnc = "git add . && git commit --allow-empty-message -m \"\"";

      # add and commit AND PUSH changes, with and without a message
      shove = "!git add . && git commit -m \"$1\" && git push origin && :";
      shovenc = "!git add . && git commit --allow-empty-message -m \"\" && git push origin";


      # list commits in short form, with colors and branch/tag annotations
      hist = "log --pretty=format:'%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cgreen\\ [%cn]' --decorate --date=short";
      hsit = "!git hist";

      # similar to hist but includes a list of files changed in commit
      histf = "log --pretty=format:'%C(yellow)%h%Cred%d\\ %Creset%s%Cgreen\\ [%cn]' --decorate --numstat";
      hsitf = "!git histf";

      # graph view of a project's commit history
      histg = "log --graph --pretty=format:'%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cgreen\\ [%cn]' --decorate --date=short";
      hsitg = "!git histg";

      # pass in the name or email address of someone involved with the project
      whois = "!sh -c 'git log -i -1 --pretty=\"format:%an <%ae>\n\" --author=\"$1\"' -";

      # List Aliases
      al = "!git config -l | grep alias | cut -c 7-";

      # open the url for the current repo in the browser
      browse = "!open `git remote -v | grep fetch | awk '{print $2}' | sed 's=git@=https://=' | sed 's=com:=com/='`";


    };
  };
  programs.gh = {
    enable = true;
  };
}
