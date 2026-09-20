# Build and deploy the blog posts to GitHub Pages.

.PHONY: help build build-local clean deploy serve

help:
	@echo "  make build        build for GitHub Pages (sets BASE_URL)"
	@echo "  make build-local  build for local viewing"
	@echo "  make serve        build locally and serve on :8000"
	@echo "  make deploy       build and push to gh-pages"
	@echo "  make clean        remove _build"

build:
	BASE_URL=/MarriageNSFG/ jupyter book build --html
	touch _build/html/.nojekyll

build-local:
	jupyter book build --html

clean:
	rm -rf _build

deploy: build
	ghp-import -n -p -f _build/html

serve: build-local
	cd _build/html && python -m http.server 8000
