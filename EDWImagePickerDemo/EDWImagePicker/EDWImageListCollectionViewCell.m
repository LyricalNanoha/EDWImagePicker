//
//  EDWImageListCollectionViewCell.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImageListCollectionViewCell.h"


@implementation EDWImageListCollectionViewCell{
    UIImageView * _imageView;
    UILabel * _numberLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:_imageView];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setClipsToBounds:YES];
        [_imageView release];
        
        CGFloat numberWidth = 20;
        
        _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - numberWidth - 5, 5 , numberWidth, numberWidth)];
        [_numberLabel.layer setCornerRadius:numberWidth/2];
        [_numberLabel setClipsToBounds:YES];
        [_numberLabel setFont:[UIFont systemFontOfSize:14]];
        [_numberLabel setTextColor:[UIColor whiteColor]];
        [_numberLabel setTextAlignment:NSTextAlignmentCenter];
        [_numberLabel.layer setBorderWidth:1];
        [_numberLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_numberLabel setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:_numberLabel];
        [_numberLabel release];
    }
    return self;
}



- (void)setAsset:(PHAsset *)asset{
    if (_asset) {
        [_asset release];
        _asset = [asset retain];
    }else{
        _asset = [asset retain];
    }
    if (!asset) {
        return;
    }
    CGFloat multiple = [UIScreen mainScreen].scale;
    
//    PHImageRequestOptions * opt =[[PHImageRequestOptions alloc] init];
//    [opt setResizeMode:PHImageRequestOptionsResizeModeExact];
//
//    [self.imageManager requestImageForAsset:asset targetSize:CGSizeMake(kImageWidth * multiple, kImageWidth * multiple ) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//
//        NSData * data = UIImagePNGRepresentation(result);
//        UIImage * image = [[UIImage alloc] initWithData:data scale:multiple];
//        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue]==0){
//            [_imageView setImage:image];
//        } else {
//            [_imageView setImage:image];
//        }
//
//    }];
//    [opt release];
    
    if (self.requestID > 0) {
        [[PHImageManager defaultManager] cancelImageRequest:self.requestID];
    }
    
    
    PHImageRequestOptions * opt = [[PHImageRequestOptions alloc] init];
    [opt setSynchronous:YES];
    
    self.requestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(self.frame.size.width * multiple, self.frame.size.width * multiple) contentMode:PHImageContentModeAspectFit options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue]==0){
            if (self.requestID == [[info objectForKey:@"PHImageResultRequestIDKey"] integerValue]) {
                [_imageView setImage:result];
            }
        }
    }];
    [opt release];
}

- (void) setNumber:(NSInteger)number{
    if (number == 0) {
        [_numberLabel setText:@""];
        [_numberLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_numberLabel setBackgroundColor:[UIColor clearColor]];
    }else{
        [_numberLabel setBackgroundColor:[UIColor greenColor]];
        [_numberLabel setText:[NSString stringWithFormat:@"%ld",number]];
        [_numberLabel.layer setBorderColor:[UIColor clearColor].CGColor];
    }
}


//- (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize {
//    CGAffineTransform scaleTransform;
//    CGPoint origin;
//
//    if (image.size.width > image.size.height) {
//        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
//        CGFloat scaleRatio = newSize / image.size.height;
//        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
//        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
//        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
//    } else {
//        CGFloat scaleRatio = newSize / image.size.width;
//        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
//
//        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
//    }
//
//    CGSize size = CGSizeMake(newSize, newSize);
//    //创建画板为(400x400)pixels
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
//    } else {
//        UIGraphicsBeginImageContext(size);
//    }
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    //将image原始图片(400x200)pixels缩放为(800x400)pixels
//    CGContextConcatCTM(context, scaleTransform);
//    //origin也会从原始(-100, 0)缩放到(-200, 0)
//    [image drawAtPoint:origin];
//
//    //获取缩放后剪切的image图片
//    image = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//    return image;
//
//}
//
//- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//
//    }
//
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//
//    }
//}


- (void)dealloc
{
    self.asset = nil;
    [super dealloc];
}



@end
