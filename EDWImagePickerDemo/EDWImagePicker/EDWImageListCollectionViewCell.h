//
//  EDWImageListCollectionViewCell.h
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

#define kImageWidth [UIScreen mainScreen].bounds.size.width/4.0-0.5

@interface EDWImageListCollectionViewCell : UICollectionViewCell

@property (retain,nonatomic) PHAsset * asset;

@property (assign,nonatomic) PHImageRequestID requestID;

- (void) setNumber:(NSInteger)number;

@end
