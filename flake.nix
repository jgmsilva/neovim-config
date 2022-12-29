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

          nvim-treesitter

          nvim-treesitter-textobjects

          vim-fugitive
          vim-rhubarb
          gitsigns-nvim

          lualine-nvim
          tokyonight-nvim
          indent-blankline-nvim
          comment-nvim
          vim-sleuth

          telescope-nvim
          plenary-nvim

        ];
        customRC = ''
        luafile ${./init.lua}
        luafile ${./remaps.lua}
        '';
      };
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.neovim;

  };
}