### Code Challenge - CLI Data Store w/Transactions

Running the application:
(You'll need to clone the repo first)
```
$ ruby ruby-cli.rb
```

You can use the following, to interact with the CLI:
```
SET <key> <value> - store the value for key
GET <key>         - return the current value for key
DELETE <key>      - remove the entry for key
COUNT <value>     - return the number of keys that have the given value
BEGIN             - start a new transaction
COMMIT            - complete the current transaction
ROLLBACK          - revert to state prior to BEGIN call
```

To quit the application, use `Ctrl-C` to send an interrupt.
