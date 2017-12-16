# Makefile
# Tarini Bhatnagar, December 2017
# This makefile runs all the analysis of the Chocolate Bar Ratings project from raw data to render the project report.

#run from top to bottom
all: doc/Create_report.md

# Clean data
results/tidy_choc_data.csv: data/flavors_of_cacao.csv src/Clean.R
		Rscript src/Clean.R data/flavors_of_cacao.csv results/tidy_choc_data.csv

# Analysis (Joining tables for plotting on world map)
results/stat_summary.csv results/join_company_location.csv results/join_bean_origin.csv: results/tidy_choc_data.csv src/Analysis.R
		Rscript src/Analysis.R results/tidy_choc_data.csv results/stat_summary.csv results/join_company_location.csv results/join_bean_origin.csv

# Create plots (Boxplot, Scatterplot, World map of company location & bean origin)
results/figures/rating_boxplot.png results/figures/rating_cocoa_scatter.png results/figures/world_comp_loc.png results/figures/world_bean_origin.png: results/tidy_choc_data.csv results/join_company_location.csv results/join_bean_origin.csv src/Plots.R
		Rscript src/Plots.R results/tidy_choc_data.csv results/join_company_location.csv results/join_bean_origin.csv results/figures/rating_boxplot.png results/figures/rating_cocoa_scatter.png results/figures/world_comp_loc.png results/figures/world_bean_origin.png

# Make final project report
doc/Create_report.md: src/Create_report.Rmd results/stat_summary.csv results/figures/rating_boxplot.png results/figures/rating_cocoa_scatter.png results/figures/world_comp_loc.png results/figures/world_bean_origin.png
		Rscript -e 'ezknitr::ezknit("src/Create_Report.Rmd", out_dir = "doc")'

# Remove files
clean:
		rm -f results/tidy_choc_data.csv
		rm -f results/stat_summary.csv
		rm -f results/join_company_location.csv
		rm -f results/join_bean_origin.csv
		rm -f results/figures/rating_boxplot.png
		rm -f results/figures/rating_cocoa_scatter.png
		rm -f results/figures/world_comp_loc.png
		rm -f results/figures/world_bean_origin.png
		rm -f doc/Create_Report.html
		rm -f doc/Create_Report.md
