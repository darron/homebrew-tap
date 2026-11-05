import hashlib
import io
import subprocess
import tarfile
import tempfile
import unittest
from pathlib import Path

from update_fbhook import render, update


class FbhookUpdateTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.tap = self.root / 'tap'
        (self.tap / 'Formula').mkdir(parents=True)
        self.path = self.tap / 'Formula/fbhook.rb'
        self.revision = 'b' * 40
        hashes = {f'fbhook_0.2.0_{os_name}_{arch}.tar.gz': 'a' * 64
                  for os_name in ('darwin', 'linux') for arch in ('amd64', 'arm64')}
        self.original = render('v0.2.0', hashes, self.revision)
        self.path.write_text(self.original)
        self.assets = self.make_assets('v0.3.0')

    def make_assets(self, tag):
        folder = self.root / tag
        folder.mkdir()
        for os_name in ('darwin', 'linux'):
            for arch in ('amd64', 'arm64'):
                path = folder / f'fbhook_{tag[1:]}_{os_name}_{arch}.tar.gz'
                with tarfile.open(path, 'w:gz') as archive:
                    for name in ('fbhook', 'LICENSE', 'README.md', 'THIRD_PARTY_NOTICES.txt'):
                        content = f'{os_name}:{arch}:{name}'.encode()
                        info = tarfile.TarInfo(name)
                        info.size = len(content)
                        archive.addfile(info, io.BytesIO(content))
        self.checksums(folder)
        return folder

    def checksums(self, folder):
        lines = []
        for path in sorted(folder.glob('*.tar.gz')):
            line = hashlib.sha256(path.read_bytes()).hexdigest() + '  ' + path.name + '\n'
            path.with_name(path.name + '.sha256').write_text(line)
            lines.append(line)
        (folder / 'SHA256SUMS').write_text(''.join(lines))

    def apply(self, tag='v0.3.0', assets=None, revision=None):
        return update(self.tap, tag, assets or self.assets, revision or self.revision)

    def test_publishes_four_exact_archives_and_is_idempotent(self):
        other = self.tap / 'Formula/otgo.rb'
        other.write_text('untouched')
        self.assertTrue(self.apply())
        text = self.path.read_text()
        for path in self.assets.glob('*.tar.gz'):
            self.assertIn('https://github.com/darron/fbhook/releases/download/v0.3.0/' + path.name, text)
            self.assertIn(hashlib.sha256(path.read_bytes()).hexdigest(), text)
        self.assertIn('prefix.install "THIRD_PARTY_NOTICES.txt"', text)
        self.assertIn('skip_clean "bin/fbhook"', text)
        self.assertIn('sha=' + self.revision + ' clean', text)
        self.assertNotIn('depends_on', text)
        self.assertEqual(other.read_text(), 'untouched')
        subprocess.run(['ruby', '-c', self.path], check=True, capture_output=True)
        self.assertFalse(self.apply())

    def test_refuses_downgrade_and_changed_same_release(self):
        self.apply()
        original = self.path.read_bytes()
        older = self.make_assets('v0.2.0')
        with self.assertRaisesRegex(ValueError, 'downgrade'):
            self.apply('v0.2.0', older)
        with self.assertRaisesRegex(ValueError, 'same release'):
            self.apply(revision='c' * 40)
        archive = next(self.assets.glob('*.tar.gz'))
        # A valid but replaced archive must also be refused for the same tag.
        archive.write_bytes(archive.read_bytes() + b'changed')
        self.checksums(self.assets)
        with self.assertRaises(ValueError):
            self.apply()
        self.assertEqual(original, self.path.read_bytes())

    def test_refuses_corrupt_missing_extra_and_symlinked_assets(self):
        archive = next(self.assets.glob('*.tar.gz'))
        original = archive.read_bytes()
        archive.write_bytes(b'corrupt')
        with self.assertRaises(ValueError):
            self.apply()
        archive.write_bytes(original)
        checksum = archive.with_name(archive.name + '.sha256')
        text = checksum.read_text()
        checksum.unlink()
        with self.assertRaises(ValueError):
            self.apply()
        checksum.symlink_to(self.assets / 'SHA256SUMS')
        with self.assertRaises(ValueError):
            self.apply()
        checksum.unlink()
        checksum.write_text(text)
        (self.assets / 'extra').write_text('unexpected')
        with self.assertRaises(ValueError):
            self.apply()
        self.assertEqual(self.original, self.path.read_text())

    def test_refuses_unexpected_archive_members_even_with_valid_checksums(self):
        archive = next(self.assets.glob('*.tar.gz'))
        with tarfile.open(archive, 'w:gz') as bundle:
            info = tarfile.TarInfo('../outside')
            info.size = 1
            bundle.addfile(info, io.BytesIO(b'x'))
        self.checksums(self.assets)
        with self.assertRaises(ValueError):
            self.apply()
        self.assertEqual(self.original, self.path.read_text())

    def test_refuses_unstable_tags_and_bad_revisions(self):
        for tag in ('v0.3.0-rc1', '0.3.0', 'v00.3.0', 'v1.2.3\n', '../../main', 'v1.2.3;pwd'):
            with self.subTest(tag=tag), self.assertRaises(ValueError):
                self.apply(tag)
        for revision in ('a' * 39, 'A' * 40, 'g' * 40, 'sha -X main.value=bad'):
            with self.subTest(revision=revision), self.assertRaises(ValueError):
                self.apply(revision=revision)
        self.assertEqual(self.original, self.path.read_text())

    def test_preserves_manual_formula_changes_and_rejects_symlink(self):
        for text in (self.original + '# manual\n', self.original.replace('license "MIT"', 'license "BSD"'),
                     self.original.replace('darwin_arm64.tar.gz', 'darwin_amd64.tar.gz')):
            self.path.write_text(text)
            with self.assertRaisesRegex(ValueError, 'unrecognized'):
                self.apply()
            self.assertEqual(text, self.path.read_text())
        self.path.unlink()
        target = self.root / 'original'
        target.write_text(self.original)
        self.path.symlink_to(target)
        with self.assertRaises(ValueError):
            self.apply()
        self.assertEqual(self.original, target.read_text())


if __name__ == '__main__':
    unittest.main()
