{ config
, pkgs
, libs
, ...
}: {

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins =
      let
        fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
            pname = "${libs.strings.sanitizeDerivationName repo}";
            version = ref;
            src = builtins.fetchGit {
              url = "https://github.com/${repo}.git";
              ref = ref;
              rev = rev;
            };
          };

        pluginGit = owner: repo: rev: sha256: pkgs.vimUtils.buildVimPlugin {

          pname = repo;
          version = rev;
          src = pkgs.fetchFromGitHub {
            owner = owner;
            repo = repo;
            rev = rev;
            sha256 = sha256;
          };
        };

        keymapConfig = pkgs.vimUtils.buildVimPlugin {
          name = "keymap-config";
          src = ../config/nvim/keymapconfig;
        };

        config = pkgs.vimUtils.buildVimPlugin {
          name = "config";
          src = ../config/nvim/config;
        };
      in

      with pkgs.vimPlugins; [
        {
          plugin = config;
          type = "lua";
          config = builtins.readFile ../config/nvim/config.lua;
        }
        # theme
        {
          plugin = dracula-vim;
          type = "lua";
          config = builtins.readFile ../config/nvim/color.lua;
        }

        #keymap
        {
          plugin = keymapConfig;
          type = "lua";
          config = builtins.readFile ../config/nvim/keymap.lua;
        }

        #lsp
        {
          plugin = nvim-lspconfig;
          type = "lua";
          config = builtins.readFile ../config/nvim/lsp.lua;
        }
        lsp-inlayhints-nvim
        cmp-nvim-lsp
        cmp-buffer
        nvim-cmp
        luasnip
        lspkind-nvim
        null-ls-nvim
        markdown-preview-nvim
        nvim-jdtls
        # (fromGitHub "HEAD" "mechatroner/rainbow_csv")
        blamer-nvim

        dressing-nvim
        rust-tools-nvim
        rustaceanvim
        nvim-notify
        vim-android
        neoconf-nvim

        #file tree
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = builtins.readFile ../config/nvim/filetree.lua;
        }
        nvim-web-devicons

        # buffer
        {
          plugin = bufferline-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/bufferline.lua;
        }
        {

          plugin = toggleterm-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/toggleterm.lua;
        }

        #cosmetic
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/indentline.lua;
        }
        rainbow-delimiters-nvim
        promise-async
        {
          plugin = nvim-ufo;
          type = "lua";
          config = builtins.readFile ../config/nvim/fold.lua;
        }

        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/lualine.lua;
        }
        {
          plugin = nvim-colorizer-lua;
          type = "lua";
          config = ''

            -- nvim-colorizer
            require("colorizer").setup()
          '';
        }

        #git
        octo-nvim
        vim-fugitive
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/gitsigns.lua;
        }
        trouble-nvim

        #addon app
        vim-dadbod-ui
        vim-dadbod
        {
          plugin = rest-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/rest.lua;
        }

        #auto
        cmp-tabnine
        copilot-vim
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = builtins.readFile ../config/nvim/autopairs.lua;
        }

        #quality of life
        {
          plugin = comment-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/comment.lua;
        }
        nvim-ts-context-commentstring
        nvim-ts-autotag
        vim-move
        vim-visual-multi
        vim-surround
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/telescope.lua;
        }
        {
          plugin = auto-save-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/autosave.lua;
        }
        {
          plugin = refactoring-nvim;
          type = "lua";
          config = builtins.readFile ../config/nvim/refactoring.lua;
        }
        {
          plugin = nvim-spectre;
          type = "lua";
          config = builtins.readFile ../config/nvim/spectre.lua;
        }

        #session
        {
          plugin = auto-session;
          type = "lua";
          config = builtins.readFile ../config/nvim/session.lua;
        }

        #debugger
        {
          plugin = nvim-dap;
          type = "lua";
          config = builtins.readFile ../config/nvim/dap.lua;
        }
        nvim-dap-ui
        nvim-dap-virtual-text
        telescope-dap-nvim
        nvim-dap-go

        #misc
        popup-nvim
        plenary-nvim
        registers-nvim
        suda-vim
        nui-nvim
        {
          plugin = harpoon;
          type = "lua";
          config = builtins.readFile ../config/nvim/harpoon.lua;
        }
        vim-sneak
        {
          plugin = nvim-config-local;
          type = "lua";
          config = builtins.readFile ../config/nvim/local.lua;
        }

        playground
        {
          plugin = (nvim-treesitter.withPlugins (_: nvim-treesitter.allGrammars ++ [
            nvim-treesitter-parsers.wgsl
            nvim-treesitter-parsers.astro

            # (pkgs.tree-sitter.buildGrammar
            #   {
            #     language = "wgsl";
            #     version = "40259f3";
            #     src = pkgs.fetchFromGitHub {
            #       owner = "szebniok";
            #       repo = "tree-sitter-wgsl";
            #       rev = "40259f3c77ea856841a4e0c4c807705f3e4a2b65";
            #       sha256 = "sha256-voLkcJ/062hzipb3Ak/mgQvFbrLUJdnXq1IupzjMJXA=";
            #     };
            #   })
            # (pkgs.tree-sitter.buildGrammar {
            #   language = "astro";
            #   version = "e122a8f";
            #   src = pkgs.fetchFromGitHub {
            #     owner = "virchau13";
            #     repo = "tree-sitter-astro";
            #     rev = "e122a8fcd07e808a7b873bfadc2667834067daf1";
            #     sha256 = "sha256-iCVRTX2fMW1g40rHcJEwwE+tfwun+reIaj5y4AFgmKk=";
            #   };
            # })
          ]
          ));
          type = "lua";
          config = builtins.readFile ../config/nvim/treesitter.lua;
        }
        (vim-wakatime.overrideAttrs
          (old: {
            patchPhase = ''
              # Move the BufEnter hook from the InitAndHandleActivity call
              # to the common HandleActivity call. This is necessary because
              # InitAndHandleActivity prompts the user for an API key if
              # one is not found, which breaks the remote plugin manifest
              # generation.
              substituteInPlace plugin/wakatime.vim \
                --replace 'autocmd BufEnter,VimEnter' \
                          'autocmd VimEnter' \
                --replace 'autocmd CursorMoved,CursorMovedI' \
                          'autocmd CursorMoved,CursorMovedI,BufEnter'
            '';
            configurePhase = ''
              export 
            '';
          }))
      ];
  };
}
