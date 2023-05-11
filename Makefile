install:
	docker-compose up -d --build || docker compose up -d --build
	docker-compose exec monolog-viewer composer install || docker compose exec monolog-viewer composer install

start:
	docker-compose up -d || docker compose up -d

bash:
	docker-compose exec monolog-viewer bash || docker compose exec monolog-viewer bash
