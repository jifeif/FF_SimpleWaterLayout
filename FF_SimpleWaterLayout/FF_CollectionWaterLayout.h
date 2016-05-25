//
//  FF_CollectionWaterLayout.h
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/23.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FF_CollectionWaterLayout;
@protocol FF_CollectionWaterLayoutDelegate <NSObject>
@optional
- (CGFloat)heightOfItems:(FF_CollectionWaterLayout *)layout andHeightOfIndexPath:(NSIndexPath *)indexPath;
@end

@interface FF_CollectionWaterLayout : UICollectionViewLayout
@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) NSInteger numberOfColumn;
@property (nonatomic, weak) id<FF_CollectionWaterLayoutDelegate> delegate;
@end
