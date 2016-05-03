//
//  MainCollectionViewCell.h
//  TestGroupBuying
//
//  Created by SMartP on 16/2/25.
//  Copyright © 2016年 SMartP. All rights reserved.
//

#import <UIKit/UIKit.h>
@class dealModel;

@interface MainCollectionViewCell : UICollectionViewCell

-(void)makeUIWithModel:(dealModel *)model;

@end
