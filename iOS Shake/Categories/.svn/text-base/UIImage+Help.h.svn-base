//
//  UIImage+Help.h
//  开店宝
//
//  Created by bysun on 14-8-21.
//  Copyright (c) 2014年 bysun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Help)

+ (CGSize)compressRatioWithMinSize:(NSInteger)minSize ForSize:(CGSize)size;

//等比压缩，且最大边为maxSize
+ (CGSize)compressRatioWithMaxSize:(NSInteger)maxSize ForSize:(CGSize)size;
//等比压缩,适应size
- (CGSize)compressToFitSize:(CGSize)size;
//等比压缩，且最小边为minSize
- (UIImage*)compressionRatioWithMinSize:(NSInteger)minSize;

//等比压缩，且最大边为maxSize
- (UIImage*)compressionRatioWithMaxSize:(NSInteger)maxSize;

//获取新的size
- (CGSize)compressRatioWithMaxSize:(NSInteger)maxSize;

//获取新的size
- (CGSize)compressRatioWithMinSize:(NSInteger)minSize;
//指定宽高比来截取图片中间部分（ratio值为 ---宽：高）
+ (UIImage*)cropImageWithImage:(UIImage *)image Ratio:(float)ratio;//


+ (UIImage *)cropImageWithImage:(UIImage *)theimage frame:(CGRect)frame;


+(UIImage*) imageWithColor:(UIColor*)color;

- (BOOL)legalImage;

-(UIImage*)getGrayImage;
- (UIImage *)resizeToWidth:(CGFloat)width height:(CGFloat)height;
- (UIImage *)cropImageWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
+ (UIImage *)fixOrientation:(UIImage *)aImage;//图片方向修复
@end
