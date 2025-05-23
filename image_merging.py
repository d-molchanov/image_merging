from PIL import Image, UnidentifiedImageError
import os
from pathlib import Path
from argparse import ArgumentParser

try:
    if hasattr(Path, 'walk'):
        def walk(top, topdown=True, onerror=None, follow_symlinks=False):
            yield from Path(top).walk(topdown, onerror, follow_symlinks)
    else:
        raise ImportError('Path.walk is not available.')
except (ImportError, AttributeError):
    walk = os.walk

class Filepath:

    def __init__(self):
        self._name = None
        self._suffix = None
        self._extension = None

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        self._name = value

    @property
    def suffix(self):
        return self._suffix
    
    @suffix.setter
    def suffix(self, value):
        self._suffix = value

    @property
    def extension(self):
        return self._extension

    @extension.setter
    def extension(self, value):
        self._extension = value

class ImageMerger:

    def check_suffixes(self, basename: str, suffixes: list) -> list:
        for s in suffixes:
            if basename.endswith(s):
                return [basename[:-len(s)], s]
        return []

    def validate_filename(self, path: str | Path, extensions: list, suffixes: list):
        filename = Path(path)
        filepath = Filepath()
        filepath.extension = filename.suffix
        if filepath.extension in extensions:
            basename = filename.stem
            try:
                filepath.name, filepath.suffix = self.check_suffixes(basename, suffixes)
                # return filepath
            except ValueError:
                pass
        return filepath

    # def get_files_from_directory(self, directory: Path, suffixes: list):
    #     result = {}
    #     for root, dirs, files in directory.resolve().walk():
    #         for f in files:
    #             filename = Path(root / f).resolve()
    #             basename = filename.stem
    #             for s in suffixes:
    #                 if basename.endswith(s):
    #                     print(basename[:-len(s)])
    #                     if basename[:-len(s)] in result:
    #                         result[basename[:-len(s)]].append(filename)
    #                     else:
    #                         result[basename[:-len(s)]] = [filename]
    #     for key, values in result.items():
    #         print(f'{key}:')
    #         for v in values:
    #             print(f'\t{v}')
    #     return result
                    
    def get_files_from_directory(self, directory: Path, extensions: list, suffixes: list):
        result = {}
        for root, dirs, files in directory.resolve().walk():
            for f in files:
                filename = Path(root / f).resolve()
                data = self.validate_filename(filename, extensions, suffixes)
                if data:
                    print(filename, data.name, data.suffix, data.extension)
                    output_file = filename.parent / f'{data.name}{data.extension}'
                    if output_file in result:
                        result[output_file].append(filename)
                    else:
                        result[output_file] = [filename]
        for key, values in result.items():
            print(f'{key}:')
            for v in values:
                print(f'\t{v}')
        return result

    def merge_images_in_directory(self, directory: Path, extensions: list, suffixes: list):
        files = self.get_files_from_directory(directory, extensions, suffixes)
        try:
            for key, value in files.items():
                if len(value) > 1:
                    sorted_values = sorted(value)
                    # sorted_values = value
                    images = []
                    heights = []
                    widths = []
                    try:
                        for v in sorted_values:
                                img = Image.open(v)
                                w, h = img.size
                                heights.append(h)
                                widths.append(w)
                                images.append(img)
                        new_image = Image.new('RGB', (max(widths), sum(heights)))
                        dh = 0
                        for i, h in zip(images, heights):
                            new_image.paste(i, (0, dh))
                            dh += h
                        print(f'{directory.resolve() / key = }')
                        new_image.save(f'{directory.resolve() / key}')
                    except UnidentifiedImageError:
                        pass

        except AttributeError:
            print('There is no files to merge.')



def test():
    image_merger = ImageMerger()
    directory = Path('./test')
    extensions = ['.jpg', '.png', '.jpeg']
    suffixes = ['_main', '_профиль']
    print(f'{directory.resolve() = }')
    image_merger.merge_images_in_directory(directory, extensions, suffixes)

if __name__ == '__main__':
    test()