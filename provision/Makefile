build:
	cd docker/frontend && docker build \
		--target base \
		--tag bjason01/vet-front:latest \
		.

	cd docker/frontend && docker build \
		--target frontend \
		--tag bjason01/vet-front:develop \
		.

.PHONY: push
push: build
	docker push \
		bjason01/vet-front:latest

	docker push \
		bjason01/vet-front:develop