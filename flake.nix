{
	description = "This flake manages the Underrepresentation Theory project.";

	inputs.nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";

	outputs = inputs:
		let
			supportedSystems = [
				"x86_64-linux"
				"aarch64-linux"
				"x86_64-darwin"
				"aarch64-darwin"
			];
			forEachSupportedSystem = f: inputs.nixpkgs.lib.genAttrs supportedSystems (system: f {
				pkgs = import inputs.nixpkgs { inherit system; };
			});
		in {
			devShells = forEachSupportedSystem ({ pkgs }: {
				default = pkgs.mkShell {
					venvDir = ".venv";
					packages = let
						myRPackages = with pkgs.rPackages; [
							Matrix
							SnowballC
							TDA
							deldir
							dplyr
							feather
							flexdashboard
							ggplot2
							gutenbergr
							jsonlite
							lsa
							pagedown
							plotly
							readr
							remotes
							resampledata
							reticulate
							rhdf5
							rmarkdown
							s2
							scales
							sf
							shiny
							showtext
							showtextdb
							stringr
							sysfonts
							textdata
							tidyr
							tidytext
							tidyverse
							tinytex
							units
							word2vec
							wordcloud
						];
						myPythonPackages = with pkgs.python313Packages; [
							colorama
							ipykernel
							jupyter-core
							jupyterlab
							matplotlib
							numpy
							openpyxl
							pandas
							pip
							plotly
							scipy
							seaborn
							statistics
							tables
							venvShellHook
						];
					in with pkgs; [
						git-lfs
						R
						rstudio
						rounded-mgenplus
						poetry
						python313
					] ++ myRPackages ++ myPythonPackages;
				};
			});
		};
}
