# kosodate_que

![スクリーンショット 2023-06-19 23 34 05](https://github.com/yamachita0109/kosodate_que/assets/24501645/6d1816a9-00b8-4c90-9a61-8f603f0d894b)

## SetUP

```bash
# PJ
$ cp .env.sample .env
$ docker-compose up -d --build
$ docker-compose run --rm web bundle install

# DB
$ docker-compose run --rm web rails db:create
$ docker-compose run --rm web rails db:migrate

# front
$ yarn install
$ yarn build
$ docker-compose run --rm web rails tailwindcss:build

# web
open http://localhost:3001

# smtp(mailcatcher)
open http://localhost:1080
```

## Dev

```bash
# ts/vue
yarn watch 

# Design
docker-compose run --rm web rails tailwindcss:watch
```
