# github-enterprise-releases.json
Convert https://enterprise.github.com/releases.rss to smaller JSON.

## Alfred Workflow

Download and install [GitHub Enterprise Server releases.alfredworkflow](https://github.com/kyanny/github-enterprise-releases.json/blob/main/GitHub%20Enterprise%20Server%20releases.alfredworkflow).

## Shell function

```sh
ghes-versions() {
  curl -s https://raw.githubusercontent.com/kyanny/github-enterprise-releases.json/main/releases.json | jq -r '.[].title' | sort -V | perl -nle 'BEGIN{ $, = "\n"; @not_eleven = () };
/^11\./ ? print : push @not_eleven, $_;
END{ print @not_eleven }'
}
```
