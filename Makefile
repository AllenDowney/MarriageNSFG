PROJECT_NAME = MarriageNSFG

# Notebooks are edited as jupytext markdown under notebooks/. The .md is the
# source of truth and is tracked; the .ipynb is generated and gitignored.
NB_DIR = notebooks
NOTEBOOKS = $(basename $(notdir $(wildcard $(NB_DIR)/*.md)))

help:
	@echo "make env         create the environment (mamba)"
	@echo "make env-update  update it from environment.yml"
	@echo "make install     install the nsfg package in editable mode"
	@echo "make data        rebuild the harmonized data from data/raw"
	@echo "make notebooks   .md -> .ipynb"
	@echo "make markdown    .ipynb -> .md (after editing in Jupyter)"
	@echo "make execute     run every notebook in place"
	@echo "make codebooks   fetch the NSFG codebooks"
	@echo "make lint / format / tests / clean"

## mamba, not conda -- the conda solver takes minutes on this environment
CONDA = mamba

env:
	$(CONDA) env create -f environment.yml

env-update:
	$(CONDA) env update -f environment.yml --prune

env-remove:
	$(CONDA) env remove -n MarriageNSFG

install:
	python -m pip install -e ".[dev]"

notebooks:
	@for nb in $(NOTEBOOKS); do \
	  jupytext --to ipynb --update -o $(NB_DIR)/$$nb.ipynb $(NB_DIR)/$$nb.md || exit 1; \
	done

markdown:
	@for nb in $(NOTEBOOKS); do \
	  jupytext --to md:myst -o $(NB_DIR)/$$nb.md $(NB_DIR)/$$nb.ipynb || exit 1; \
	done

## Execute every notebook. Failures are tolerated so that one parked notebook
## does not stop the rest; the summary says which ran clean. See Task 17.
execute: notebooks
	@for nb in $(NOTEBOOKS); do \
	  printf '  %-26s ' $$nb; \
	  jupyter nbconvert --execute --inplace --allow-errors \
	      $(NB_DIR)/$$nb.ipynb >/dev/null 2>&1 \
	    && python scripts/check_notebook.py $(NB_DIR)/$$nb.ipynb \
	    || echo "FAILED TO RUN"; \
	done

## clean_nsfg is the hub: it reads data/raw and writes data/interim
data:
	jupytext --to ipynb --update -o $(NB_DIR)/clean_nsfg.ipynb $(NB_DIR)/clean_nsfg.md
	jupyter nbconvert --execute --inplace $(NB_DIR)/clean_nsfg.ipynb

codebooks:
	python scripts/fetch_codebooks.py

lint:
	ruff check nsfg/ scripts/ tests/

format:
	ruff format nsfg/ scripts/ tests/
	jupytext --pipe black $(NB_DIR)/*.md

tests:
	pytest -v

clean:
	rm -f $(NB_DIR)/*.ipynb $(NB_DIR)/archive/*.ipynb
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true

.PHONY: help env env-update env-remove install notebooks markdown execute data codebooks lint format tests clean
