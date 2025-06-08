from PIL import Image, UnidentifiedImageError
from enum import Enum
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

class Direction(Enum):
    HORIZONTAL = 0 
    VERTICAL = 1

class Alignment(Enum):
    CENTER = 0
    LEFT = 1
    RIGHT = 2
    TOP = 3
    BOTTOM = 4

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

    # def check_suffixes(self, basename: str, suffixes: list) -> list:
    #     for s in suffixes:
    #         if basename.endswith(s):
    #             return [basename[:-len(s)], s]
    #     return []

    # def validate_filename(self, path: str | Path, extensions: list, suffixes: list):
    #     filename = Path(path)
    #     filepath = Filepath()
    #     filepath.extension = filename.suffix
    #     if filepath.extension in extensions:
    #         basename = filename.stem
    #         try:
    #             filepath.name, filepath.suffix = self.check_suffixes(basename, suffixes)
    #             # return filepath
    #         except ValueError:
    #             pass
    #     return filepath



    # def get_files_from_directory(self, directory: Path, extensions: list, suffixes: list):
    #     result = {}
    #     print(f'{directory = }, {type(directory)}')
    #     for root, dirs, files in walk(directory.resolve()):
    #         for f in files:
    #             filename = (Path(root) / Path(f)).resolve()
    #             data = self.validate_filename(filename, extensions, suffixes)
    #             if data:
    #                 print(filename, data.name, data.suffix, data.extension)
    #                 output_file = filename.parent / f'{data.name}{data.extension}'
    #                 if output_file in result:
    #                     result[output_file].append(filename)
    #                 else:
    #                     result[output_file] = [filename]
    #     for key, values in result.items():
    #         print(f'{key}:')
    #         for v in values:
    #             print(f'\t{v}')
    #     return result

    # def merge_images_in_directory(self, directory: Path, extensions: list, suffixes: list, direction: str='h', align: str='b', color: str='#ffffff' ):
    #     files = self.get_files_from_directory(directory, extensions, suffixes)
    #     print(f'{extensions = }, {suffixes = }, {files = }')
    #     try:
    #         for key, value in files.items():
    #             if len(value) > 1:
    #                 sorted_values = sorted(value)
    #                 # sorted_values = value
    #                 images = []
    #                 heights = []
    #                 widths = []
    #                 try:
    #                     for v in sorted_values:
    #                             img = Image.open(v)
    #                             w, h = img.size
    #                             heights.append(h)
    #                             widths.append(w)
    #                             images.append(img)
    #                     if direction == 'v':
    #                         new_image = Image.new('RGB', (max(widths), sum(heights)), color)
    #                         dh = 0
    #                         if align == 'l':
    #                             for i, h in zip(images, heights):
    #                                 new_image.paste(i, (0, dh))
    #                                 dh += h
    #                         elif align == 'c':
    #                             x_c = max(widths) // 2
    #                             for i, h, w in zip(images, heights, widths):
    #                                 new_image.paste(i, (x_c - w // 2, dh))
    #                                 dh += h
    #                         elif align == 'r':
    #                             w_max = max(widths)
    #                             for i, h, w in zip(images, heights, widths):
    #                                 new_image.paste(i, (w_max - w, dh))
    #                                 dh += h
    #                         print(f'{directory.resolve() / key = }')
    #                         new_image.save(f'{directory.resolve() / key}')
    #                     elif direction == 'h':
    #                         new_image = Image.new('RGB', (sum(widths), max(heights)), color)
    #                         dw = 0
    #                         if align == 't':
    #                             for i, w in zip(images, widths):
    #                                 new_image.paste(i, (dw, 0))
    #                                 dw += w
    #                         elif align == 'c':
    #                             y_c = max(heights) // 2
    #                             for i, h, w in zip(images, heights, widths):
    #                                 new_image.paste(i, (dw, y_c - h // 2))
    #                                 dw += w
    #                         elif align == 'b':
    #                             h_max = max(heights)
    #                             for i, h, w in zip(images, heights, widths):
    #                                 new_image.paste(i, (dw, h_max - h))
    #                                 dw += w
    #                         print(f'{directory.resolve() / key = }')
    #                         new_image.save(f'{directory.resolve() / key}')
    #                 except UnidentifiedImageError:
    #                     pass

    #     except AttributeError:
    #         print('There is no files to merge.')

    def convert_files_to_paths(self, root: str | Path, files: list):
        return [Path(root) / Path(f) for f in files]

    def get_filepaths(self, directory: str | Path, subdirectories=True):
        path = Path(directory)
        result = {}
        for root, dirs, files in walk(path.resolve()):
            files = self.convert_files_to_paths(root, files)
            result[root] = files
            if not subdirectories:
                return result
        return result

    def get_image_filepaths(self, input_filepaths: dict, extensions: list):
        filepaths = {}
        for root, files in input_filepaths.items():
            filtered_files = list(filter(lambda f: f.suffix in extensions, files))
            if filtered_files:
                filepaths[root] = filtered_files
        return filepaths

    def filter_files(self, basenames: dict, files: list, suffix: str):
        for f in files:
            if f.stem.endswith(suffix):
                basename = f.stem[:-len(suffix)]
                if basename in basenames:
                    basenames[basename].append(f)
                else:
                    basenames[basename] = [f]

    def get_filepaths_with_suffixes(self, input_filepaths: dict, suffixes: list):
        filepaths = {}
        for root, files in input_filepaths.items():
            basenames = {}
            for s in suffixes:
                self.filter_files(basenames, files, s)
            filtered_basenames = {}
            for key, value in basenames.items():
                if len(value) > 1:
                    filtered_basenames[key] = value
            if filtered_basenames:
                filepaths[root] = filtered_basenames

        # for k1, v1 in filepaths.items():
        #     print(f'{k1} - {type(k1)}:')
        #     for k2, v2 in v1.items():
        #         print(f'\t{k2} - {type(k2)}:')
        #         for v3 in v2:
        #             print(f'\t\t{v3} - {type(v3)}')
        #         print(self.create_filename(k1, k2, '.jpg'))
        # print(filepaths)
        return filepaths

    def fulfill_axis(self, vector: list, initial_coordinate: float | int):
        v_0 = int(initial_coordinate)
        result = []
        for v in vector:
            result.append(v_0)
            v_0 += v
        return result
        # Or just with itertools: from itertools import accumulate:
        # return list(accumulate(vector, initial=initial_coordinate))

    def align_rectangles(self, vector: list, max_value: float | int, alignment: Alignment):
        result = []
        if alignment == Alignment.CENTER:
            k = 0.5
        elif alignment in (Alignment.LEFT, Alignment.TOP):
            k = 0
        elif alignment in (Alignment.RIGHT, Alignment.BOTTOM):
            k = 1
        else:
            #TODO improve this peace of code
            raise ValueError
        for v in vector:
            result.append(int(k*(max_value - v)))
        return result

    def process_directory(self, directory: str | Path, extensions: list, suffixes: list, direction: Direction, alignment: Alignment, color: str, result_extension: str):
        all_filepaths = self.get_filepaths(Path(directory), subdirectories=True)
        image_filepaths = self.get_image_filepaths(all_filepaths, extensions)
        # print_dict(image_filepaths)
        filepaths_with_suffixes = self.get_filepaths_with_suffixes(image_filepaths, suffixes)
        for root, names in filepaths_with_suffixes.items():
            for name, paths in names.items():
                new_image = self.merge_images(paths, direction, alignment, color)
                filename = self.create_filename(root, name, result_extension)
                self.save_image(new_image, filename)

    def merge_images(
            self,
            filepaths: list[Path],
            direction: Direction=Direction.VERTICAL,
            alignment: Alignment=Alignment.CENTER,
            color: str='#ffffff'
        ):
        images = []
        widths = []
        heights = []
        for f in filepaths:
            try:
                img = Image.open(f)
                w, h = img.size
                images.append(img)
                widths.append(w)
                heights.append(h)
            except FileNotFoundError as e:
                print(e)
            except UnidentifiedImageError as e:
                print(e)
        if not images:
            return

        image_size = ()
        images_coordinates = {'x': [], 'y': []}
        if direction == Direction.VERTICAL:
            image_size = (max(widths), sum(heights))
            images_coordinates['y'] = self.fulfill_axis(heights, 0)
            images_coordinates['x'] = self.align_rectangles(
                widths, image_size[0], alignment
            )
        elif direction == Direction.HORIZONTAL:
            image_size = (sum(widths), max(heights))
            images_coordinates['x'] = self.fulfill_axis(widths, 0)
            images_coordinates['y'] = self.align_rectangles(
                heights, image_size[1], alignment
            )
        else:
            print(f'Direction {direction} is not acceptable.')
            # TODO raise exeption
        # print(*images, sep='\n')
        # print(f'{image_size = }')
        # print(f'{images_coordinates = }')
        new_image = Image.new('RGB', image_size, color)
        for i, x, y in zip(images, images_coordinates['x'], images_coordinates['y']):
            new_image.paste(i, (x, y))
        return new_image

    def create_filename(self, root: str | Path, name: str, extension: str):
        return Path(root) / f'{name}{extension}'

    def save_image(self, image: Image, filename: str | Path):
        image.save(filename)


def print_dict(d: dict):
    for key, value in d.items():
        print(f'{key}:')
        for v in value:
            print(f'\t{v.stem}')


def test_3():
    image_merger = ImageMerger()
    filepaths_to_merge= [
        Path('/home/dmitry/Projects/python/(2025_05_25)_image_merger/test/test_profile.png'),
        Path('/home/dmitry/Projects/python/(2025_05_25)_image_merger/test/test_main.png'),
        Path('/home/dmitry/Projects/python/(2025_05_25)_image_merger/test/txt_document.png'),
        Path('/home/dmitry/Projects/python/(2025_05_25)_image_merger/test/test_профиль.png')
    ]
    direction = 'h'
    alignment = 'b'
    color = '#ffffff'
    merged_image = image_merger.merge_images(filepaths_to_merge, direction=direction, alignment=alignment, color=color)
    filename = 'merged_image.jpg'
    image_merger.save_image(merged_image, filename)  

def test_4():
    image_merger = ImageMerger()
    # directory = './test'
    directory = '.'
    extensions = ['.jpg', '.png', '.jpeg']
    # suffixes = ['_main', '_профиль', '_profile']
    suffixes = ['_profile', '_main', '_профиль']
    direction = Direction.HORIZONTAL
    direction = Direction.VERTICAL
    alignment = Alignment.RIGHT
    color = '#ffffff'
    extension = '.png'
    all_filepaths = image_merger.get_filepaths(directory, subdirectories=True)
    image_filepaths = image_merger.get_image_filepaths(all_filepaths, extensions)
    # print_dict(image_filepaths)
    filepaths_with_suffixes = image_merger.get_filepaths_with_suffixes(image_filepaths, suffixes)
    for root, names in filepaths_with_suffixes.items():
        for name, paths in names.items():
            new_image = image_merger.merge_images(paths, direction, alignment, color)
            filename = image_merger.create_filename(root, name, extension)
            image_merger.save_image(new_image, filename)

def test_5():
    image_merger = ImageMerger()
    # directory = './test'
    directory = '.'
    extensions = ['.jpg', '.png', '.jpeg']
    # suffixes = ['_main', '_профиль', '_profile']
    suffixes = ['_profile', '_main', '_профиль']
    direction = Direction.HORIZONTAL
    direction = Direction.VERTICAL
    alignment = Alignment.RIGHT
    color = '#ffffff'
    extension = '.png'
    image_merger.process_directory(directory, extensions, suffixes, direction, alignment, color, extension)

if __name__ == '__main__':
    # test()
    # test_2()
    # test_3()
    # test_4()
    test_5()