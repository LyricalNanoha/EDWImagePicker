//
//  EDWImagePickerTool.h
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>


@interface EDWImagePickerTool : NSObject

+ (void) getPhotosWithAssetArrays:(NSArray *)asset andFinishHandler: (void (^)(NSArray * result))handler;


+ (void) getPhotosWithAssetArrays:(NSArray *)asset andMaxSize:(CGFloat)max andFinishHandler: (void (^)(NSArray * result))handler;

@end
