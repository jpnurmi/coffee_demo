Install [json-server](https://www.npmjs.com/package/json-server):

```
$ sudo npm install -g json-server
```

Run the server:

```
$ json-server --port 5000 --watch test.json
```

Set `localhost` and `GET` in `config.yaml`:

```yaml
url: 'http://localhost:5000'
method: 'GET'
username: 'foo'
password: 'bar'
vendors:
  private: [mk8]
  public: [gcp, azu, aws, doc]

```
