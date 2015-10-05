# MoinMoin on Docker

## インストール

自己署名の証明書の作成

```bash
$ ./bootstrap.sh
```

docker-compose.ymlの編集

```bash
$ mv doker-compose.yml.default docker-compose.yml
```

User Dataの作成

```bash
$ vi backup/user
```

MoinMoinイメージのビルド

```bash
$ cd moin
$ docker build -t masato/moin .
```

OpenRestyの起動

```bash
$ docker-compose up -d openresty
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[Masato Shimizu](https://github.com/masato)