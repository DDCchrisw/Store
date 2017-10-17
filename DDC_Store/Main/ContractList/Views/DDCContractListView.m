//
//  DDCContractListView.m
//  DDC_Store
//
//  Created by Christopher Wood on 10/17/17.
//  Copyright © 2017 DDC. All rights reserved.
//

#import "DDCContractListView.h"
#import "DDCNavigationBar.h"
#import "DDCUserProfileView.h"
#import "DDCBarBackgroundView.h"

@interface DDCContractListView()
{
    BOOL _setConstraints;
}

@property (nonatomic, strong) UIButton * rightNavButton;

@end

@implementation DDCContractListView

- (instancetype)initWithDelegate:(id<DDCContractListViewDelegate>)delegate dataSource:(id<UICollectionViewDataSource>)dataSource
{
    if (!(self = [self init])) return nil;
    
    self.userInteractionEnabled = YES;
    self.delegate = delegate;
    self.dataSource = dataSource;
    return self;
}

- (instancetype)init
{
    if (!(self = [super init])) return nil;
    
    self.image = [UIImage imageNamed:@"personalCenterBackground"];
    [self addSubview:self.navigationBar];
    [self addSubview:self.profileView];
    [self addSubview:self.collectionHolderView];
    return self;
}

- (void)updateConstraints
{
    if (_setConstraints == NO)
    {
        [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(NAVBAR_HI+STATUSBAR_HI);
        }];
        
        [self.collectionHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(231);
            make.left.right.bottom.equalTo(self);
        }];
        
        [self.profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(42);
            make.top.equalTo(self).with.offset(98);
            make.height.mas_equalTo(self.profileView.height);
        }];
    }
    [super updateConstraints];
}

#pragma mark - Events
- (void)rightNavButtonSelected:(UIButton *)navButton
{
    [self.delegate rightNaviBtnPressed];
}

#pragma mark - Setters
- (void)setDelegate:(id<DDCContractListViewDelegate>)delegate
{
    _delegate = delegate;
    self.collectionHolderView.collectionView.delegate = delegate;
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource
{
    _dataSource = dataSource;
    self.collectionHolderView.collectionView.dataSource = dataSource;
}
    
#pragma mark - Getters
- (DDCNavigationBar *)navigationBar
{
    if (!_navigationBar)
    {
        UILabel * navigationTitle = [[UILabel alloc]  init];
        navigationTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        navigationTitle.textColor = UIColor.whiteColor;
        navigationTitle.text = NSLocalizedString(@"课程管家", @"");
        navigationTitle.textAlignment = NSTextAlignmentCenter;
        [navigationTitle setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        _navigationBar = [[DDCNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, NAVBAR_HI+STATUSBAR_HI) titleView:navigationTitle leftButton:nil rightButton:self.rightNavButton];
        _navigationBar.bottomLineHidden = YES;
    }
    return _navigationBar;
}
    
- (UIButton *)rightNavButton
{
    if (!_rightNavButton)
    {
        _rightNavButton = [[UIButton alloc] init];
        [_rightNavButton addTarget:self action:@selector(rightNavButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_rightNavButton setTitle:NSLocalizedString(@"登陆账号", @"") forState:UIControlStateNormal];
        [_rightNavButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_rightNavButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _rightNavButton;
}

- (DDCBarBackgroundView *)collectionHolderView
{
    if (!_collectionHolderView)
    {
        _collectionHolderView = [[DDCBarBackgroundView alloc] initWithRectCornerTopCollectionViewFrame:CGRectZero hasShadow:NO];
        _collectionHolderView.backgroundColor = UIColor.clearColor;
        
        __weak typeof(self) weakSelf = self;
        DDCBottomButton * btn = [[DDCBottomButton alloc] initWithTitle:NSLocalizedString(@"创建新合同", @"") style:DDCBottomButtonStylePrimary handler:^{
            [weakSelf.delegate createNewContract];
        }];
        
        [_collectionHolderView.bottomBar addBtn:btn];
    }
    return _collectionHolderView;
}

- (DDCUserProfileView *)profileView
{
    if (!_profileView)
    {
        _profileView = [[DDCUserProfileView alloc] init];
    }
    return _profileView;
}

@end
