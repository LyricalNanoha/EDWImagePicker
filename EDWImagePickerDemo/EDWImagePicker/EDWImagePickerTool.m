//
//  EDWImagePickerTool.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImagePickerTool.h"

@implementation EDWImagePickerTool

+ (void) getPhotosWithAssetArrays:(NSArray *)asset andFinishHandler: (void (^)(NSArray * result))handler{
    [self getPhotosWithAssetArrays:asset andMaxSize:CGFLOAT_MAX andFinishHandler:handler];
}

+ (void) getPhotosWithAssetArrays:(NSArray *)assets andMaxSize:(CGFloat)max andFinishHandler:(void (^)(NSArray * result))handler{
    NSMutableArray * array = [NSMutableArray array];
    for (PHAsset * asset in assets) {
        
        CGFloat multiple = [UIScreen mainScreen].scale;
        CGFloat pixelWidth = asset.pixelWidth / multiple;
        CGFloat pixelHeight = asset.pixelHeight / multiple;
        
        CGFloat maxed = max<240 ? max:240;
        
        CGSize size = CGSizeMake(pixelWidth, pixelHeight);
        if (pixelHeight > pixelWidth) {
            if (pixelHeight > maxed) {
                size = CGSizeMake(pixelWidth/pixelHeight * maxed, maxed);
            }
        }else{
            if (pixelWidth > maxed) {
                size = CGSizeMake(maxed, pixelHeight/pixelWidth * maxed);
            }
        }
        
        if (max == CGFLOAT_MAX) {
            size = PHImageManagerMaximumSize;
        }
        
        PHImageRequestOptions * opt = [[PHImageRequestOptions alloc] init];
        [opt setSynchronous:YES];
        
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue]==0){
                [array addObject:result];
            }
        }];
        [opt release];
    }
    
    handler (array);
    
}

@end
