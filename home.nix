{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    
    ".config/niri/config.kdl".source = ./niri/config.kdl;

    ".config/waybar/style.css".source = ./waybar/style.css;
    ".config/waybar/config.jsonc".source = ./waybar/config.jsonc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/echo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;

    # zsh aliases
    shellAliases = {
      ll = "ls -lha";
    };

    # Full initContent replaces initExtra
    initContent = ''
      # --- Kitty GPU Fix ---
      export KITTY_USE_EGL=0

      # --- Starship Prompt ---
      eval "$(starship init zsh)"
    '';
  };

  # Starship config
  programs.starship = {

    # Enable starship first
    enable = true;

    # Configuration
    settings = {
    "$schema" = "https://starship.rs/config-schema.json";

      format = "[┏](#a3aed2)[ ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n┗━$character";

      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";

        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = ''[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'';
      };

      git_status = {
        style = "bg:#394260";
        format = ''[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'';
      };

      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      rust = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      golang = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      php = {
        symbol = "";
        style = "bg:#212736";
        format = ''[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)'';
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = ''[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'';
      };
    };
  };
  
  programs.kitty = {
    enable = true;

    themeFile = "OneDark";

    extraConfig = ''
      # BEGIN_KITTY_FONTS
      font_family      family="JetBrainsMonoNL Nerd Font Mono"
      bold_font        auto
      italic_font      auto
      bold_italic_font auto
      # END_KITTY_FONTS
    
      font_size 14.0
    '';
  };
  


  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";

    logo = {
      type = "builtin";   # or "ascii", "file"
      height = null;
      padding = { top = 0; left = 0; right = 4; };
    };

    display = {
      stat = false;
      pipe = false;
      showErrors = false;
      disableLinewrap = true;
      hideCursor = false;
      separator = ": ";
      color = {
        keys = "";
        title = "";
        output = "";
        separator = "";
      };
    
      brightColor = true;
        duration = {
          abbreviation = false;
          spaceBeforeUnit = "default";
        };
    
        size = {
          maxPrefix = "YB";
          binaryPrefix = "iec";
          ndigits = 2;
          spaceBeforeUnit = "default";
        };
    
        temp = {
          unit = "D";
          ndigits = 1;
          color = {
            green = "32";
            yellow = "93";
            red = "91";
          };
          spaceBeforeUnit = "default";
        };
    
        percent = {
          type = [ "num" "num-color" ];
          ndigits = 0;
          color = {
            green = "32";
            yellow = "93";
            red = "91";
          };
          spaceBeforeUnit = "default";
          width = 0;
        };
      
        bar = {
          char = {
            elapsed = "■";
            total = "-";
          };
          border = {
            left = "[ ";
            right = " ]";
            leftElapsed = "";
            rightElapsed = "";
          };
          color = {
            elapsed = "auto";
            total = "97";
            border = "97";
          };
          width = 10;
        };
      
        fraction = {
          ndigits = 2;
        };
      
        noBuffer = false;
      
        key = {
          width = 0;
          type = "string";
          paddingLeft = 0;
        };
      
        freq = {
          ndigits = 2;
          spaceBeforeUnit = "default";
        };
      
        constants = [];
      };

      general = {
        thread = true;
        processingTimeout = 5000;
        detectVersion = true;
      };

      modules = [
        {
          type = "title";
          key = " ";
          keyIcon = "";
          fqdn = false;
          color = {
            user = "";
            at = "";
            host = "";
          };
        }
        {
	  type = "separator";
          string = "-";
          outputColor = "";
          times = 0;
        }
        { type = "os"; keyIcon = ""; }
        { type = "host"; keyIcon = "󰌢"; }
        { type = "kernel"; keyIcon = ""; }
        { type = "uptime"; keyIcon = ""; }
        { type = "packages"; keyIcon = "󰏖"; disabled = [ "winget" ]; combined = false; }
        { type = "shell"; keyIcon = ""; }
        { type = "display"; keyIcon = "󰍹"; compactType = "none"; preciseRefreshRate = false; order = null; }
        { type = "de"; keyIcon = ""; slowVersionDetection = false; }
        { type = "wm"; keyIcon = ""; detectPlugin = false; }
        { type = "wmtheme"; keyIcon = "󰓸"; }
        { type = "theme"; keyIcon = "󰉼"; }
        { type = "icons"; keyIcon = ""; }
        { type = "font"; keyIcon = ""; }
        { type = "cursor"; keyIcon = "󰆿"; }
        { type = "terminal"; keyIcon = ""; }
        { type = "terminalfont"; keyIcon = ""; }
        { type = "cpu"; keyIcon = ""; temp = false; showPeCoreCount = false; }
        { type = "gpu"; keyIcon = "󰾲"; driverSpecific = false; detectionMethod = "pci"; temp = false; hideType = "none"; percent = { green = 50; yellow = 80; type = 0; }; }
        { type = "memory"; keyIcon = ""; percent = { green = 50; yellow = 80; type = 0; }; }
        { type = "swap"; keyIcon = "󰓡"; separate = false; percent = { green = 50; yellow = 80; type = 0; }; }
        { type = "disk"; keyIcon = ""; showRegular = true; showExternal = true; showHidden = false; showSubvolumes = false; showReadOnly = true; showUnknown = false; folders = ""; hideFolders = ""; hideFS = ""; useAvailable = false; percent = { green = 50; yellow = 80; type = 0; }; }
        { type = "battery"; keyIcon = ""; temp = false; percent = { green = 50; yellow = 20; type = 0; }; }
        { type = "poweradapter"; keyIcon = "󰚥"; }
        { type = "locale"; keyIcon = ""; }
        "break"
        { type = "colors"; key = " "; keyIcon = ""; symbol = "block"; paddingLeft = 0; block = { width = 3; range = [0 15]; }; }
      ];
    };
  };
}
