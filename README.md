# Brew coffee

## Configuration

Configure the address, credentials, and vendors in `assets/config.yaml`:

```yaml
url: 'http://12.34.56.78:5000'
username: 'foo'
password: 'bar'
vendors:
  private: [mk8]
  public: [gcp, azu, aws, doc]
```

## Assets

Provide SVG assets (`asset/<vendor>.svg`) for each vendor.
