//
//  UIImage+Help.m
//  开店宝
//
//  Created by bysun on 14-8-21.
//  Copyright (c) 2014年 bysun. All rights reserved.
//

#import "UIImage+Help.h"

#import "AppMacro.h"

@implementation UIImage (Help)

- (CGSize)compressToFitSize:(CGSize)size {
    CGSize imgsize = self.size;
    float scaleW = size.width/self.size.width;
    float scaleH = size.height/self.size.height;
    float scale = MIN(scaleW, scaleH);
    return CGSizeMake(imgsize.width*scale, imgsize.height*scale);
}
+(UIImage*) imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGSize)compressRatioWithMinSize:(NSInteger)minSize ForSize:(CGSize)size
{
    if (size.height > size.width) {
        CGFloat scale = minSize/size.width;
        size.height *= scale;
        size.width = minSize;
    } else {
        CGFloat scale = minSize/size.height;
        size.height = minSize;
        size.width *= scale;
    }
    
    return size;
}

//等比压缩，且最大边为maxSize
+ (CGSize)compressRatioWithMaxSize:(NSInteger)maxSize ForSize:(CGSize)size
{
    if (size.height > size.width) {
        CGFloat scale = maxSize/size.width;
        size.height = maxSize;
        size.width *= scale;
    } else {
        CGFloat scale = maxSize/size.height;
        size.height *= scale;
        size.width = maxSize;
    }
    
    return size;
}

//等比压缩，且最小边为minSize
- (UIImage*)compressionRatioWithMinSize:(NSInteger)minSize
{
    CGSize size = [UIImage compressRatioWithMinSize:minSize ForSize:self.size];
    
    UIGraphicsBeginImageContext(size);
	[self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}

//等比压缩，且最大边为maxSize
- (UIImage*)compressionRatioWithMaxSize:(NSInteger)maxSize
{
    CGSize size = [UIImage compressRatioWithMaxSize:maxSize ForSize:self.size];
    
    UIGraphicsBeginImageContext(size);
	[self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}


//指定宽高比来截取图片中间部分（ratio值为 ---宽：高）
+ (UIImage*)cropImageWithImage:(UIImage *)theimage Ratio:(float)ratio{
    CGSize size = theimage.size;
    CGSize newsize = CGSizeMake(size.width, size.height);
    if (size.width/size.height > ratio) {
        newsize.width = size.height * ratio;
    }
    else if (size.width/size.height < ratio){
        newsize.height = size.width / ratio;
    }
    else {
        return theimage;
    }
    
    //CGRect frame = CGRectMake((size.width-newsize.width)/2, 999, 1000, 1000);
    CGRect frame = CGRectMake((size.width-newsize.width)/2, (size.height-newsize.height)/2, newsize.width, newsize.height);
    //frame = CGRectIntegral(frame);
#if 1
    CGImageRef cr = CGImageCreateWithImageInRect([theimage CGImage], CGRectIntegral(frame));
    UIImage *cropped = [UIImage imageWithCGImage:cr];
    CGImageRelease(cr);
    return cropped;
#else
    return [self cropImageWithImage:theimage frame:frame];
    #endif
}
+ (UIImage *)cropImageWithImage:(UIImage *)theimage frame:(CGRect)frame{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:frame];
    imageview.image = theimage;
    imageview.contentMode = UIViewContentModeScaleAspectFill;
    
    UIGraphicsBeginImageContext(frame.size);
    //截图层放入上下文中
    [imageview.layer renderInContext:UIGraphicsGetCurrentContext()];
    //从上下文中获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束截图
    UIGraphicsEndImageContext();
    return image;

}

- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height {
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}
//获取新的size
- (CGSize)compressRatioWithMaxSize:(NSInteger)maxSize
{
    return [UIImage compressRatioWithMaxSize:maxSize ForSize:self.size];
}

//获取新的size
- (CGSize)compressRatioWithMinSize:(NSInteger)minSize
{
    return [UIImage compressRatioWithMinSize:minSize ForSize:self.size];
}

//自定义方法，筛选图片
- (BOOL)legalImage
{
    //UIImage *caremaImage = [self compressionRatioWithMinSize:MIN_SIZE_COMPRESSIONRATIO];
    CGSize size = [self compressRatioWithMinSize:MIN_SIZE_COMPRESSIONRATIO];
    if (size.height<=LIMIT_SIZE_IMAGE && size.width<=LIMIT_SIZE_IMAGE)
    {
        return YES;
    }
    return NO;
}

-(UIImage*)getGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil, width, height, 8, 0, colorSpace, 0);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef image = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:image];
    CGImageRelease(image);
    CGContextRelease(context);
    
    return grayImage;
}
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height {
    CGSize size = CGSizeMake(width, height);
    if (&UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    } else {
        //UIGraphicsBeginImageContext(size);
    }
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
