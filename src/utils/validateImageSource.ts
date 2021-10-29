import type { ImageSource } from '../types';

const URI_SHEMES = ['file:', 'data:', 'http:', 'https:'];

export function assertImageSource(imageSource: ImageSource) {
  const objectTypeSource = imageSource as { uri: string };

  if (
    typeof imageSource === 'number' ||
    (objectTypeSource.uri &&
      URI_SHEMES.some((scheme) => objectTypeSource.uri.startsWith(scheme)))
  ) {
    return;
  }

  throw new Error('Invalid image source');
}
