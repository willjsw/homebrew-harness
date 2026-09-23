# 전역 `harness` 명령을 깐다.
#
#   brew tap willjsw/harness
#   brew trust willjsw/harness     # 공식이 아닌 탭은 신뢰를 밝혀야 읽힌다
#   brew install --HEAD harness
#
# **PATH 에 따로 등록할 것이 없다.** Homebrew 가 bin 을 이미 PATH 에 두므로
# 설치 즉시 어느 디렉터리에서나 돈다.
#
# 템플릿은 실행 파일 옆에 있어야 한다(`bin/harness` 가 `../templates` 를 읽는다).
# 그래서 트리를 통째로 libexec 에 넣고 bin 에는 심볼릭 링크만 건다 —
# 파이썬이 `__file__` 을 실제 경로로 풀어 주므로 링크를 타도 템플릿을 찾는다.
#
# **셔뱅을 고쳐 쓰지 않는다.** `harness install` 이 이 실행 파일을 대상 리포의
# `.harness/` 로 복사하고 그 사본은 커밋된다. 셔뱅을 이 기계의 python 경로로 박으면
# 그 리포를 받은 다른 사람이 돌리지 못한다. `env python3` 로 두고, 대신
# depends_on 으로 쓸 수 있는 python 이 PATH 에 있게 한다.
class Harness < Formula
  desc "Generate an AI development harness from one config file"
  homepage "https://github.com/willjsw/harness"
  license "MIT"
  head "https://github.com/willjsw/harness.git", branch: "main"

  # 설정을 tomllib 로 읽는다 — 3.11 이상이 필요하고 그 밖의 의존성은 없다.
  depends_on "python@3.13"

  def install
    libexec.install "bin", "templates", "harness.toml"
    bin.install_symlink libexec/"bin/harness"
  end

  def caveats
    <<~EOS
      To set up a project, run this inside that repository:
        harness install
        git config core.hooksPath script/githooks
        harness doctor

      `harness install` copies this executable and its templates into the
      repository's `.harness/`, and that copy is committed. It is the canonical
      version for that repository — upgrading the global CLI does not reach it.
      Anyone who clones that repository also needs python3 3.11 or newer.
    EOS
  end

  test do
    assert_match "harness install", shell_output("#{bin}/harness help")

    # 빈 리포에 깔고 검사까지 통과하는지 본다 — 설치가 실제로 쓸 수 있는 상태인지.
    system "git", "init", "-q", testpath
    system bin/"harness", "install", "--target", testpath
    system bin/"harness", "check", "--target", testpath
  end
end
