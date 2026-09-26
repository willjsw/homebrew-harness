# homebrew-harness

[`willjsw/harness`](https://github.com/willjsw/harness) 의 Homebrew 탭.

```bash
brew tap willjsw/harness
brew trust willjsw/harness
brew install --HEAD harness
```

`brew tap willjsw/harness` 는 이 리포(`homebrew-harness`)를 찾는다 — Homebrew 가
`homebrew-` 접두사를 붙여 해석하므로 URL 을 적을 필요가 없다.

`brew trust` 가 필요한 이유: Homebrew 는 공식 저장소가 아닌 탭의 포뮬러를 **신뢰를 밝히기
전에는 읽지 않는다.** 포뮬러는 설치할 때 실행되는 루비 코드라서다. 승인은 이 기계의
`~/.homebrew/trust.json` 에 남고, 탭마다 한 번이다.

**PATH 에 따로 등록할 것이 없다.** Homebrew 가 `bin` 을 이미 PATH 에 둔다.

## 업데이트

```bash
brew update
brew upgrade --fetch-HEAD harness
```

`--HEAD` 설치는 버전이 없어 `--fetch-HEAD` 를 줘야 원격 main 의 새 커밋을 본다.

## 릴리스

지금은 `head` 만 있어 `--HEAD` 로 설치한다. 안정 버전을 내려면 하네스 리포에 태그를 올리고
이 포뮬러에 세 줄을 더한다.

```ruby
url "https://github.com/willjsw/harness/archive/refs/tags/v0.1.0.tar.gz"
sha256 "..."   # brew fetch --build-from-source harness 가 알려 준다
version "0.1.0"
```

포뮬러는 `Formula/harness.rb` 하나다. 하네스 자체의 코드와 템플릿은 저쪽 리포에 있다.
