PROJECT_NAME = MarriageNSFG
PYTHON_VERSION = 3.11
PYTHON_INTERPRETER = python

# Notebooks are edited as jupytext markdown. The .md is the source of truth;
# the .ipynb is generated from it and executed. See Task 1 on PROJECT_BOARD.md.
NOTEBOOKS = clean_nsfg marriage_education marriage_education_cps fertility \
            intent marriage_lifelines agebaby_lifelines validate_sex_ratio ipums

create_environment:
	conda create --name $(PROJECT_NAME) python=$(PYTHON_VERSION) -y
	@echo ">>> conda env created. Activate with:\nconda activate $(PROJECT_NAME)"

delete_environment:
	conda env remove --name $(PROJECT_NAME)

requirements:
	$(PYTHON_INTERPRETER) -m pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m pip install -r requirements-dev.txt

## Regenerate .ipynb from the markdown sources
notebooks:
	@for nb in $(NOTEBOOKS); do \
	  echo "  $$nb.md -> $$nb.ipynb"; \
	  jupytext --to ipynb --update -o $$nb.ipynb $$nb.md || exit 1; \
	done

## Re-export the markdown from the notebooks (after editing in Jupyter)
markdown:
	@for nb in $(NOTEBOOKS); do \
	  echo "  $$nb.ipynb -> $$nb.md"; \
	  jupytext --to md:myst -o $$nb.md $$nb.ipynb || exit 1; \
	done

## Execute the notebooks in place
execute: notebooks
	@for nb in $(NOTEBOOKS); do \
	  echo "  executing $$nb"; \
	  jupyter nbconvert --execute --inplace $$nb.ipynb || exit 1; \
	done

## Rebuild the harmonized data from the raw NSFG files
data: notebooks
	jupyter nbconvert --execute --inplace clean_nsfg.ipynb

codebooks:
	$(PYTHON_INTERPRETER) scripts/fetch_codebooks.py

clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -exec rm -rf {} +

lint:
	ruff check *.py scripts/

format:
	ruff format *.py scripts/
	jupytext --pipe black $(addsuffix .md,$(NOTEBOOKS))

tests:
	pytest -v marriage_test.py survival_test.py

.PHONY: create_environment delete_environment requirements notebooks markdown \
        execute data codebooks clean lint format tests
