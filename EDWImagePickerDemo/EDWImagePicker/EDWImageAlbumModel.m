//
//  EDWImageAlbumModel.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImageAlbumModel.h"

@implementation EDWImageAlbumModel

- (void)dealloc
{
    self.collection = nil;
    self.asset = nil;
    [super dealloc];
}

@end
