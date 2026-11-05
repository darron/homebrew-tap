#!/usr/bin/env python3
"""Generate a verified fbhook binary formula without publication credentials."""
import argparse
import hashlib
import re
import tarfile
from pathlib import Path

TARGETS = [("darwin", "amd64"), ("darwin", "arm64"), ("linux", "amd64"), ("linux", "arm64")]
BINARY_URL = re.compile(
    r'^      url "https://github\.com/darron/fbhook/releases/download/(v[^"/]+)/(fbhook_[^"/]+\.tar\.gz)"\n'
    r'      sha256 "([a-f0-9]{64})"$', re.MULTILINE)


def validate_metadata(tag, revision):
    if not re.fullmatch(r'v(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)', tag):
        raise ValueError('release must be a stable vMAJOR.MINOR.PATCH tag')
    if not re.fullmatch(r'[a-f0-9]{40}', revision):
        raise ValueError('release revision must be a full lowercase Git SHA')


def version(tag):
    validate_metadata(tag, '0' * 40)
    return tuple(map(int, tag[1:].split('.')))


def archive_name(tag, os_name, arch):
    validate_metadata(tag, '0' * 40)
    if (os_name, arch) not in TARGETS:
        raise ValueError('unsupported release target')
    return f'fbhook_{tag[1:]}_{os_name}_{arch}.tar.gz'


def verify_bundle(output, tag):
    output = Path(output)
    archives = sorted(output / archive_name(tag, os_name, arch) for os_name, arch in TARGETS)
    files = archives + [p.with_name(p.name + '.sha256') for p in archives] + [output / 'SHA256SUMS']
    if set(output.iterdir()) != set(files) or any(p.is_symlink() or not p.is_file() for p in files):
        raise ValueError('release bundle has missing, extra or unsafe files')
    lines = [hashlib.sha256(p.read_bytes()).hexdigest() + '  ' + p.name + '\n' for p in archives]
    if (output / 'SHA256SUMS').read_text() != ''.join(lines):
        raise ValueError('combined release checksums do not match')
    for path, line in zip(archives, lines):
        if path.with_name(path.name + '.sha256').read_text() != line:
            raise ValueError('individual release checksum does not match')
        try:
            with tarfile.open(path, 'r:gz') as archive:
                members = archive.getmembers()
                expected = {'fbhook', 'LICENSE', 'README.md', 'THIRD_PARTY_NOTICES.txt'}
                if (len(members) != len(expected) or {m.name for m in members} != expected
                        or any(not m.isfile() or m.size == 0 for m in members)):
                    raise ValueError('unexpected release archive contents')
        except (tarfile.TarError, OSError, EOFError) as exc:
            raise ValueError('invalid release archive') from exc
    return files


def render(tag, hashes, revision):
    repo = "darron/fbhook"
    validate_metadata(tag, revision)
    if not re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', repo):
        raise ValueError('invalid repository')
    lines = ['class Fbhook < Formula', '  desc "Shared feedback intake and issue delivery"',
             f'  homepage "https://github.com/{repo}"', '  license "MIT"']
    for platform, ruby_platform in (('darwin', 'macos'), ('linux', 'linux')):
        lines.append(f'  on_{ruby_platform} do')
        for arch, ruby_arch in (('arm64', 'arm'), ('amd64', 'intel')):
            name = archive_name(tag, platform, arch)
            digest = hashes.get(name, '')
            if not re.fullmatch(r'[a-f0-9]{64}', digest):
                raise ValueError('missing verified archive checksum')
            lines.extend([f'    on_{ruby_arch} do',
                          f'      url "https://github.com/{repo}/releases/download/{tag}/{name}"',
                          f'      sha256 "{digest}"', '    end'])
        lines.append('  end')
    lines.extend(['', '  # Preserve the exact executable published on GitHub.',
                  '  skip_clean "bin/fbhook"', '', '  def install', '    bin.install "fbhook"',
                  '    prefix.install "THIRD_PARTY_NOTICES.txt"', '  end', '  test do',
                  f'    assert_equal "fbhook #{{version}} sha={revision} clean\\n", shell_output("#{{bin}}/fbhook version")',
                  '    assert_match "shared feedback", shell_output("#{bin}/fbhook help")',
                  '    assert_path_exists prefix/"THIRD_PARTY_NOTICES.txt"',
                  '  end', 'end', ''])
    return '\n'.join(lines)


def current_tag(text):
    matches = BINARY_URL.findall(text)
    tags = {tag for tag, _, _ in matches}
    if len(tags) != 1:
        raise ValueError('unrecognized formula version')
    tag = tags.pop()
    version(tag)
    hashes = {filename: digest for _, filename, digest in matches}
    revisions = re.findall(r' sha=([a-f0-9]{40}) clean', text)
    expected = {archive_name(tag, os_name, arch) for os_name, arch in TARGETS}
    if (len(matches) != 4 or set(hashes) != expected or len(revisions) != 1
            or text != render(tag, hashes, revisions[0])):
        raise ValueError('unrecognized formula; refusing to overwrite manual changes')
    return tag


def update(tap, tag, assets, revision):
    validate_metadata(tag, revision)
    assets = Path(assets)
    verify_bundle(assets, tag)
    hashes = {archive_name(tag, os_name, arch): hashlib.sha256(
        (assets / archive_name(tag, os_name, arch)).read_bytes()).hexdigest()
        for os_name, arch in TARGETS}
    path = Path(tap) / 'Formula/fbhook.rb'
    if path.is_symlink() or not path.is_file():
        raise ValueError('fbhook formula must be an existing regular file')
    text = path.read_text()
    previous = current_tag(text)
    if version(tag) < version(previous):
        raise ValueError('refusing to downgrade the stable formula')
    changed = render(tag, hashes, revision)
    if changed == text:
        return False
    if tag == previous:
        raise ValueError('refusing changed metadata for the same release')
    path.write_text(changed)
    return True


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tap-dir', required=True)
    parser.add_argument('--tag', required=True)
    parser.add_argument('--assets-dir', type=Path, required=True)
    parser.add_argument('--revision', required=True)
    args = parser.parse_args()
    try:
        changed = update(args.tap_dir, args.tag, args.assets_dir, args.revision)
    except (ValueError, OSError) as exc:
        parser.exit(1, f'Homebrew update refused: {exc}\n')
    print('Updated fbhook formula.' if changed else 'fbhook formula is already current.')


if __name__ == '__main__':
    main()
