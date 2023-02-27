{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    wrapNeovim = pkgs.neovimUtils.legacyWrapper;
  in {

    packages.x86_64-linux.neovim = wrapNeovim pkgs.neovim-unwrapped {
      configure = {
        packages.plugins.start = with pkgs.vimPlugins; [
          nvim-lspconfig
          fidget-nvim
          neodev-nvim

          nvim-cmp
          cmp-nvim-lsp
          luasnip
          cmp_luasnip

          (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
          

          nvim-treesitter-textobjects

          vim-fugitive
          vim-rhubarb
          gitsigns-nvim

          lualine-nvim
          tokyonight-nvim
          onedark-nvim
          indent-blankline-nvim
          comment-nvim
          vim-sleuth
          nvim-surround
          nvim-autopairs

          telescope-nvim
          plenary-nvim


        ];
        customRC = ''
        luafile ${./init.lua}
        '';
      };
    vimAlias = true;
    viAlias = true;
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.neovim;

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with pkgs;[ sumneko-lua-language-server ];
    };

  };
}
