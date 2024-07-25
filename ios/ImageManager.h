#import <Foundation/Foundation.h>

@interface ImageManager : NSObject

+ (CGSize)getImageCGSize:(UIImage *)imageData width:(int)width;
+ (UIImage *)scaleImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)getImageFromDictionarySource:(NSDictionary *)imageObj;

@end
