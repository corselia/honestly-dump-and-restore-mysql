# Overviews
- this app enables you to `dump MySQL data` and `restore MySQL data`
    - the data is cloned from `source_db` to `target_db`
- this app has only above function

# Required
- install gem

```bash
$ gem install mysql2
```

# Perpare
- overwrite [`config.yml`](config.yml) as your environment
    - the data of `source_db` is dumped
    - the dumped data is restored to `target_db`

# Execute
- ok, now you can execute this app

```bash
$ ruby app.rb
```

# Result
- both MySQLs have the same data

```
source_db (MySQL) ----- clone -----> target_db (MySQL)
```

# Feature
- without SQL to INSERT data
    - because of `mysqldump` command

# TOO BAD...
- it takes a long time
    - because of `mysqldump` command
- test is not written

# LICENSE
[MIT LICENSE](LICENSE)
