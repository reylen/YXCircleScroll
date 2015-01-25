//
//  YXCircleScrollView.m
//  YXCircleScroll
//
//  Created by reylen on 15-1-25.
//  Copyright (c) 2015年 ray. All rights reserved.
//

#import "YXCircleScrollView.h"

@interface YXCircleScrollView ()<UIScrollViewDelegate> {
    NSInteger   currentPage;
    NSInteger   totalPage;
}

@property (retain, nonatomic)   UIScrollView    *scrollView;
@property (retain, nonatomic)   UILabel         *titleLabel;

@property (copy, nonatomic) NSArray *dataSource;

@end

@implementation YXCircleScrollView

- (void)dealloc
{
    [_dataSource release];
    [_scrollView release];
    [_titleLabel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame dataSource:nil];
}

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *) data
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.dataSource = data;
        self.scrollView = [[[UIScrollView alloc]initWithFrame:self.bounds] autorelease];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor blackColor];
        [self addSubview:self.scrollView];
        
        // 显示图片标题
        self.titleLabel = [[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)] autorelease];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
        [self addSubview:self.titleLabel];
        
        currentPage = 0;
        totalPage = [data count];
        
        if ([data count] > 0) {
            
            [self addImageView];
            [self setCurrentShowPage:0];
            
        }
    }
    return self;
}

- (UIImage *) getImageWithIndex:(NSInteger) index {
    id obj = [_dataSource objectAtIndex:index];
    if ([obj isKindOfClass:[NSString class]]) {
        return [UIImage imageNamed:obj];
    }
    else if ([obj isKindOfClass:[UIImage class]])
    {
        return (UIImage *)obj;
    }
    else
    {
        return obj;
    }
}

// 初始化 imageView
- (void) addImageView {
    
    if (totalPage >= 2) {
        CGFloat w = CGRectGetWidth(self.bounds);
        CGFloat h = CGRectGetHeight(self.bounds);
        for (int i = 0; i < 3; i ++) {
            CGRect rect = CGRectMake(i * w, 0, w, h);
            UIImageView *imageView = [[[UIImageView alloc]initWithFrame:rect] autorelease];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            imageView.tag = 10 + i;
            imageView.clipsToBounds  = YES;

            imageView.backgroundColor = [UIColor blackColor];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];

            [self.scrollView addSubview:imageView];
        }
        
        self.scrollView.contentSize = CGSizeMake(w * 3, 0);
    }
    else
    {
        UIImageView *imageView = [[[UIImageView alloc]initWithFrame:self.scrollView.bounds] autorelease];
        imageView.backgroundColor = [UIColor blackColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        imageView.clipsToBounds  = YES;
        imageView.image = [self getImageWithIndex:0];
        [self.scrollView addSubview:imageView];
    }
}

// 设置当前显示图片
- (void) setCurrentShowPage:(NSInteger) page {
    
    self.titleLabel.text = [NSString stringWithFormat:@"第 %@ 页",@(page+1)];
    
    if (totalPage == 1) {
        return;
    }
    
    NSInteger pre = page - 1;
    if (pre < 0) {
        pre = totalPage - 1;
    }
    
    NSInteger next = page + 1;
    if (next > totalPage - 1) {
        next = 0;
    }
    
    NSInteger index[3] = {pre,page,next};
    
    for (int i = 0; i < 3; i ++) {
        NSInteger tag = 10 + i;
        UIImageView *imageView = (UIImageView *)[self.scrollView viewWithTag:tag];
        if (imageView) {
            UIImage *image = [self getImageWithIndex:index[i]];
            imageView.image = image;
        }
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.bounds), 0)];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / CGRectGetWidth(self.bounds);
    if (page == 0) {
        currentPage --;
        if (currentPage < 0) {
            currentPage = totalPage - 1;
        }
        [self setCurrentShowPage:currentPage];
    }
    else if (page == 2)
    {
        currentPage ++;
        if (currentPage > totalPage - 1) {
            currentPage = 0;
        }
        [self setCurrentShowPage:currentPage];
    }
}

@end
