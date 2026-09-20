# Build and deploy the blog posts to GitHub Pages.

.PHONY: help build build-local clean deploy serve

help:
	@echo "  make build        build for GitHub Pages (sets BASE_URL)"
	@echo "  make build-local  build for local viewing"
	@echo "  make serve        build locally and serve on :8000"
	@echo "  make deploy       build and FORCE-PUSH to the gh-pages branch"
	@echo "  make clean        remove _build"

build:
	BASE_URL=/MarriageNSFG/ jupyter book build --html
	touch _build/html/.nojekyll

build-local:
	jupyter book build --html

clean:
	rm -rf _build

## Force-pushes _build/html to the gh-pages branch of origin, replacing
## whatever is there. The first run creates the branch; after that, enable
## GitHub Pages for the repo and point it at gh-pages.
deploy: build
	ghp-import -n -p -f _build/html

serve: build-local
	cd _build/html && python -m http.server 8000
