# homebrew-harness

[`willjsw/harness`](https://github.com/willjsw/harness) 의 Homebrew 탭.

```bash
brew tap willjsw/harness
brew install --HEAD harness
```

`brew tap willjsw/harness` 는 이 리포(`homebrew-harness`)를 찾는다 — Homebrew 가
`homebrew-` 접두사를 붙여 해석하므로 URL 을 적을 필요가 없다.

**PATH 에 따로 등록할 것이 없다.** Homebrew 가 `bin` 을 이미 PATH 에 둔다.

포뮬러는 `Formula/harness.rb` 하나다. 하네스 자체의 코드와 템플릿은 저쪽 리포에 있다.
