//
//  EDWAlbumListViewController.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWAlbumListViewController.h"
#import "EDWImagePickerViewController.h"
#import "EDWImageListViewController.h"

@interface EDWAlbumListViewController ()

@end

@implementation EDWAlbumListViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self createDataSource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableViewWithStyle:UITableViewStyleGrouped];
}

- (void) createUI{
    [super createUI];
    [self createRightNavBtn];
    
    
    [self.navigationItem setTitle:@"相册"];
    
}

- (void) createRightNavBtn{
    [super createRightNavBtn];
    [_rightNavBtn setTitleColor:kSystemBlue forState:UIControlStateNormal];
    [_rightNavBtn setTitle:@"取消" forState:UIControlStateNormal];
}

-(void)rightNavBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (EDWImagePickerViewController *) navigationController{
    EDWImagePickerViewController * navigationController = (EDWImagePickerViewController *) [super navigationController];
    return navigationController;
}

- (void) createDataSource{
    [super createDataSource];
    
    
    
    
    
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        
        if (collection.assetCollectionSubtype != 205 || collection.assetCollectionSubtype != 1000000201 || collection.assetCollectionSubtype!= PHAssetCollectionSubtypeSmartAlbumVideos) {
            
            
            PHFetchOptions * options = [[PHFetchOptions alloc] init];
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
            [options setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"ascending:NO]]];
            [options setIncludeAssetSourceTypes:PHAssetSourceTypeUserLibrary];
            
            PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
            
            EDWImageAlbumModel * model = [[EDWImageAlbumModel alloc] init];
            [model setCollection:collection];
            [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
                [model setAsset:asset];
                *stop = YES;
            }];
            [model setCount:result.count];
            
            if (model.count > 0) {
                
                if (collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                    [self.dataSource insertObject:model atIndex:0];
                }else{
                    [self.dataSource addObject:model];
                }
            }
            [model release];
            
            [options release];
            
        }
    }];
    
    smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [smartAlbums enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull collection, NSUInteger idx, BOOL *stop) {
        NSLog(@"相册名字:%@,,tpye:%ld", collection.localizedTitle,collection.assetCollectionSubtype);
        
        PHFetchOptions * options = [[PHFetchOptions alloc] init];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
        [options setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"ascending:NO]]];
        [options setIncludeAssetSourceTypes:PHAssetSourceTypeUserLibrary];
        
        
        PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        EDWImageAlbumModel * model = [[EDWImageAlbumModel alloc] init];
        [model setCollection:collection];
        [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
            [model setAsset:asset];
            
            NSString *filename = [asset valueForKey:@"filename"];
            NSLog(@"filename:%@",filename);
            *stop = YES;
        }];
        [model setCount:result.count];
        
        if (model.count > 0) {
            [self.dataSource addObject:model];
        }
        
        [model release];
    }];
    
    

    
//    NSLog(@"%@",self.dataSource);
}

- (void) createTableViewWithStyle:(UITableViewStyle)style{
    [super createTableViewWithStyle:style];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

-(PHAssetCollection *)defaultAssetCollection{
    return (EDWImageAlbumModel *)[[self.dataSource firstObject] collection];;
}

-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
    return self.dataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [cell.imageView setContentMode:UIViewContentModeCenter];
        [cell.imageView setClipsToBounds:YES];
    }
    EDWImageAlbumModel * model = [self.dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:model.collection.localizedTitle];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%ld",model.count]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    PHAsset *phAsset = model.asset;
    CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    //屏幕分辨率 scale = 1 代表 分辨率是320 * 480; = 2 代表 分辨率是 640 * 960; = 3 代表 分辨率是 1242 * 2208
    CGFloat multiple = [UIScreen mainScreen].scale;
    CGFloat pixelWidth = photoWidth * multiple;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    /**
     *  PHImageManager 是通过请求的方式拉取图像，并可以控制请求得到的图像的尺寸、剪裁方式、质量，缓存以及请求本身的管理（发出请求、取消请求）等
     *
     *  @param pixelWidth 获取图片的宽
     *  @param pixelHeight 获取图片的高
     *  @param contentMode 图片的剪裁方式
     *
     *  @return
     */
    
    PHImageRequestOptions * opt =[[PHImageRequestOptions alloc] init];
    [opt setResizeMode:PHImageRequestOptionsResizeModeExact];
    [opt setSynchronous:YES];
    [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(50 * multiple, 50*multiple ) contentMode:PHImageContentModeAspectFill options:opt resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        NSData * data = UIImagePNGRepresentation(result);
        UIImage * image = [[UIImage alloc] initWithData:data scale:multiple];
        if ([[info valueForKey:@"PHImageResultIsDegradedKey"]integerValue]==0){
            [cell.imageView setImage:image];
        } else {
//            [cell.imageView setImage:image];
        }
        
    }];
    [opt release];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EDWImageAlbumModel * model = [self.dataSource objectAtIndex:indexPath.row];
    EDWImageListViewController * imageListVC = [[EDWImageListViewController alloc] initWithPHAssetCollection:model.collection];
    [self.navigationController pushViewController:imageListVC animated:YES];
    [imageListVC release];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
