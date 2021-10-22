import type { ImageSource } from '../types';

export function isImageRemoteSource(imageSource: ImageSource) {
  const objectTypeSource = imageSource as { uri: string };

  return objectTypeSource?.uri?.startsWith('http');
}

export function assertImageLocalSource(imageSource: ImageSource) {
  const objectTypeSource = imageSource as { uri: string };

  if (
    typeof imageSource === 'number' ||
    (objectTypeSource.uri &&
      (objectTypeSource.uri.startsWith('file:') ||
        objectTypeSource.uri.startsWith('data:')))
  ) {
    return;
  }

  throw new Error('Invalid image source');
}
