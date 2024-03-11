#import "ImageManager.h"
#import <React/RCTConvert.h>

@implementation ImageManager: NSObject

+ (UIImage *)scaleImage:(UIImage *)image
             size:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);

    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (CGSize)getImageCGSize:(UIImage *)imageData
            width:(int)width
{
    NSInteger imgHeight = imageData.size.height;
    NSInteger imagWidth = imageData.size.width;

    return CGSizeMake(width, imgHeight*width/imagWidth);
}

+ (UIImage *)getImageFromDictionarySource:(NSDictionary *)imageObj
{
    NSString * urlString = imageObj[@"uri"];
    UIImage * imageData;
    if([urlString hasPrefix: @"http"] || [urlString hasPrefix: @"https"]) {
        NSURL *url = [NSURL URLWithString: urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        imageData = [[UIImage alloc] initWithData:data];
    } else {
        imageData = [RCTConvert UIImage:imageObj];
    }
    return imageData;
}

@end
