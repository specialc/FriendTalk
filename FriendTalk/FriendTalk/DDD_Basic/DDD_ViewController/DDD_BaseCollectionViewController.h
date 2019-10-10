//
//  DDD_BaseCollectionViewController.h
//  FriendTalk
//
//  Created by yn2019 on 2019/9/27.
//  Copyright © 2019 zhxixh_pc. All rights reserved.
//

#import "DDD_BaseViewController.h"

@interface DDD_BaseCollectionViewController : DDD_BaseViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readonly) UICollectionView *ddd_collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *ddd_layout;

/// 注册UICollectionViewCell
- (void)ddd_registerCollectionViewCell:(UICollectionView *)collectionView;

@end
